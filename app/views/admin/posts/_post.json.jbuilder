json.extract! post, :id, :title, :perex, :body, :content_path, :position, :published_at, :series_id, :created_at, :updated_at
json.url admin_post_url(post, format: :json)
