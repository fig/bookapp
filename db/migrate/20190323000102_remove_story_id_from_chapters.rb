class RemoveStoryIdFromChapters < ActiveRecord::Migration[5.2]
  def change
    remove_column :chapters, :story_id, :integer
  end
end
