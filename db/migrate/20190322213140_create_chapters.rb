class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end
    add_index :chapters, :slug, unique: true
  end
end
