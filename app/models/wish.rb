class Wish < ActiveRecord::Base

		belongs_to :user
		has_many :products

	def get_product_name(id)
		@nm = Product.find(id)
		@nm.product_name
	end

	def get_product_image(id2)
		@img = Product.find(id2)
		@img.image_one
	end

end