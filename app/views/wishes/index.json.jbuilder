json.array!(@wishes) do |wish|
  json.extract! wish, :id, :user_id, :product_id, :amount
  json.url wish_url(wish, format: :json)
end