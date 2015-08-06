json.array!(@products) do |product|
  json.extract! product, :id, :category_id, :product_name, :description, :image_one, :price, :created_at
  json.url product_url(product, format: :json)
end
