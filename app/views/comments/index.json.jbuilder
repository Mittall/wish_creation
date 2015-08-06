json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :event_product_id, :description, :image
  json.url comment_url(comment, format: :json)
end
