class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :genres, :slug, unique: true
  end
end
