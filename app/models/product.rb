class Product < ActiveRecord::Base

	belongs_to :category
	has_many :event_products
  has_many :carts
	has_many :wishes
	validates :product_name, :presence => true
	validates :description, :presence => true
	validates :price, :presence => true

	mount_uploader :image_one, ImageUploader

	def get_category_name(id)
		@nm = Category.find(id)
		@nm.name
	end

	def get_price(id)
		@value = Product.find(id)
		@value.price
	end	

end
