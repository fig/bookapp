class CreateAnnouncements < ActiveRecord::Migration[5.2]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
    add_index :announcements, :slug, unique: true
  end
end
