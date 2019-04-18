json.extract! book, :id, :title, :prologue, :copyright, :characters, :author, :user_id, :created_at, :updated_at
json.url book_url(book, format: :json)
