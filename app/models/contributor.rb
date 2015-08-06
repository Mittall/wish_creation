class Contributor < ActiveRecord::Base
	belongs_to :user
	belongs_to :event_product
	has_many :contributed, class_name: 'Contributor', foreign_key: "user_contribute_id", dependent: :destroy


	validates_numericality_of :given_price, :greater_than_or_equal_to => 10
  

	def get_user_name(id)
	   @uname = User.find(id)
	   @uname.first_name
	end

	def get_total_contribution(id)
		@value = Contributor.where(event_product_id: id).group(:event_product_id).sum(:given_price)
		Hash h = @value
	end

	def get_contribution_id(id)
		@id = EventProduct.find(id)
		@id.event_id
	end

	def get_user_id(id)
		@uid = Event.find(id)
		@uid.user_id
  end

	def get_product_id(id)
		@pid = EventProduct.find(id)
		@pid.product_id
	end

	def get_product_image(id)
		@img= Product.find(id)
		@img.image_one
	end
	
	def get_product_name(id)
		@pname = Product.find(id)
		@pname.product_name
	end	

	def get_event_id(id)
		@name = EventProduct.find(id)
		@name.event_id
	end

	def get_event_name(id)
		@name = Event.find(id)
		@name.event_name
	end

	
end
