class Comment < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	belongs_to :user
	belongs_to :event_product

	def get_user_name(id)
		@uname = User.find(id)
		@uname.first_name
	end

	def get_user_image(id1)
		@user_image = User.find(id1)
		@user_image.image
	end
end
