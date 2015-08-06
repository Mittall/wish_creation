class EventProduct < ActiveRecord::Base
	
	belongs_to :product
	belongs_to :event
	has_many :contributors
	has_many :comments
 
	# validates_presence_of :price_to_gain
	 validates :price_to_gain, :presence => true
	 validates_numericality_of :price_to_gain, :greater_than_or_equal_to => 100
        
	def get_event_name(id1)
		@nm = Event.find(id1)
		@nm.event_name
	end

	def get_event_description(id4)
		@nm = Event.find(id4)
		@nm.event_name
	end

	def get_product_name(id2)
		@pnm = Product.find(id2)
		@pnm.product_name
	end

	def get_product_price(id3)
		@pnm = Product.find(id3)
		@p = @pnm.price		
	end

	def get_product_image(id)
		@product_image = Product.find(id)
		@product_image.image_one
	end

	def get_start_date(id)
		@sdate = Event.find(id)
		@sdate.start_date	
	end

	def get_end_date(id)
		@edate = Event.find(id)
		@edate.end_date
	end

	def get_user_id(id)
		@id = Event.find(id)
		@id.user_id
	end

end
