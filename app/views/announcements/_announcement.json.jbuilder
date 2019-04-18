json.extract! announcement, :id, :title, :content, :user_id, :slug, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
