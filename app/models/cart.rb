class Cart < ActiveRecord::Base

	belongs_to :user

	belongs_to :product
  validates_inclusion_of :qty, :in => 1..10

	def get_product_name(id)
		@nm = Product.find(id)
		@nm.product_name
	end

	def get_product_price(id1)
		@price = Product.find(id1)
		@price.price
	end

	def get_product_image(id2)
		@img = Product.find(id2)
		@img.image_one
	end

end