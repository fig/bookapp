class RemoveLikesCountFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :likes_count, :integer
  end
end
