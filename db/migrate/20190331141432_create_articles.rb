class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :articles, :slug, unique: true
  end
end
