class Event < ActiveRecord::Base

  belongs_to :user
  has_many :event_products
  has_many :products, :through => :event_products

  validates :event_name, :presence => true
  validates :description, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  
  #validates :status, :presence => true

  validates_datetime :end_date, :after => :start_date, :after_message => "End Date must be greater then Start Date." 
  validates_date :start_date, :on => :create, :on_or_after => :today, :on_or_after_message => "Start date must be a TODAY's date or next date."

=begin
  # Is this event current? Default cutoff is today
  def current?(cutoff=nil)
     cutoff ||= Time.now
     return (self.end_date || self.start_date) >= cutoff
  end

  # Is this event old? Default cutoff is yesterday
  def old?(cutoff=nil)
     cutoff ||= Time.zone.now.midnight # midnight today is the end of yesterday
     return (self.end_date || self.start_date + 1.hour) <= cutoff
  end

  # Did this event start before today but ends today or later?
  def ongoing?
      self.start_date < Time.today && self.end_date && self.end_date >= Time.today
  end

  def today?
	self.start_date == Date.today
  end

=end

  def newly?
		self.start_date == Date.today
	end

	def upcoming?
		self.start_date > Date.today
	end

	def ongoing?
		self.start_date < Date.today && self.end_date > Date.today
	end

	def finished?
		self.end_date < Date.today
	end

  #which will display and store the event status
  	def get_status
		
			if newly?
				self.status = "Newly added event"
		  elsif upcoming?
				self.status = "Upcomming event"
			elsif ongoing?
				self.status = "Ongoing event"
			elsif finished?
				self.status = "Finished event"
			else
				self.status = "Not Described"
			end
	 end
end
