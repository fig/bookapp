class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :ratings, :slug, unique: true
  end
end
