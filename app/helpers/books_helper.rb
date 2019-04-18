module BooksHelper
  def contact_user_partial_path
    if user_signed_in?
      @book.user.id != current_user.id ? 'books/show/contact_user' : 'shared/empty_partial'
    else 
      'books/show/login_required'
    end
  end

  def leave_message_partial_path
    if @message_has_been_sent
      'books/show/contact_user/already_in_touch'
    else
      'books/show/contact_user/message_form'
    end
  end
end
