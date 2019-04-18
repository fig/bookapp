class Private::ConversationsController < ApplicationController
  
  def create
    recipient_id = Book.find(params[:book_id]).user.id
    if params[:recipient_id]
      @recipient = User.find_by(id: params[:recipient_id])
      redirect_to(root_path) and return unless @recipient
      @conversation = Private::Conversation.between(current_user.id, @recipient.id)[0]
    end
    @conversation = Private::Conversation.new(sender_id: current_user.id, 
                                             recipient_id: recipient_id)

    if params[:recipient_id]
      @recipient = User.find_by(id: params[:recipient_id])
      redirect_to(root_path) and return unless @recipient
      @conversation = Private::Conversation.between(current_user.id, @recipient.id)[0]
    else
      @conversation = Private::Conversation.find_by(id: params[:conversation_id])
      redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
    end
    if @conversation.save
      Private::Message.create(user_id: current_user.id, 
                              conversation_id: @conversation.id, 
                              body: params[:message_body])

      add_to_conversations unless already_added?

      respond_to do |format|
        format.js {render partial: 'posts/show/contact_user/message_form/success'}
      end
    else
      respond_to do |format|
        format.js {render partial: 'posts/show/contact_user/message_form/fail'}
      end
    end
  end

  def close
    @conversation_id = params[:id].to_i
    session[:private_conversations].delete(@conversation_id)
 
    respond_to do |format|
      format.js
    end
  end

  def open
    if params[:recipient_id]
    @conversation = Private::Conversation.find(params[:id])
    add_to_conversations unless already_added?
    respond_to do |format|
      format.js { render partial: 'private/conversations/open' }
    end
  end

  private

  

  def add_to_conversations
    session[:private_conversations] ||= []
    session[:private_conversations] << @conversation.id
  end

  def already_added?
    session[:private_conversations].include?(@conversation.id)
  end

end
