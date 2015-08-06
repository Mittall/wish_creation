json.array!(@contributors) do |contributor|
  json.extract! contributor, :id, :user_id, :event_product_id, :given_price
  json.url contributor_url(contributor, format: :json)
end
