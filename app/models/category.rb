class Category < ActiveRecord::Base

	#require "product.rb"

	has_many :products
	#validates :category_id, :presence => true
	validates :name, :presence => true
	validates :description, :presence => true

  def self.search(search)
  		if search
    			find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  		else
    			find(:all)
  		end
	end

end
