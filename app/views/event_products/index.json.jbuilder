json.array!(@event_products) do |event_product|
  json.extract! event_product, :id, :event_id, :product_id, :price_to_gain
  json.url event_product_url(event_product, format: :json)
end
