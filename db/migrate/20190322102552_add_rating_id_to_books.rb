class AddRatingIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :rating_id, :integer
  end
end
