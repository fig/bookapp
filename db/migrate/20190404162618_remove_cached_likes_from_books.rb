class RemoveCachedLikesFromBooks < ActiveRecord::Migration[5.2]
  # def change
  #   change_table :books do |t|
  #     t.integer :cached_votes_total, default: 0
  #     t.integer :cached_votes_score, default: 0
  #     t.integer :cached_votes_up, default: 0
  #     t.integer :cached_votes_down, default: 0
  #     t.integer :cached_weighted_score, default: 0
  #     t.integer :cached_weighted_total, default: 0
  #     t.float :cached_weighted_average, default: 0.0
  #   end

  #   # Uncomment this line to force caching of existing votes
  #   # Post.find_each(&:update_cached_votes)
  # end
  def change
    remove_column :books, :cached_votes_total, :integer, default: 0
    remove_column :books, :cached_votes_score, :integer, default: 0
    remove_column :books, :cached_votes_up, :integer, default: 0
    remove_column :books, :cached_votes_down, :integer, default: 0
    remove_column :books, :cached_weighted_score, :integer, default: 0
    remove_column :books, :cached_weighted_total, :integer, default: 0
    remove_column :books, :cached_weighted_average, :float, default: 0.0
  end
end
