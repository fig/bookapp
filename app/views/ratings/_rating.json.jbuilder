json.extract! rating, :id, :name, :description, :user_id, :slug, :created_at, :updated_at
json.url rating_url(rating, format: :json)
