class User < ActiveRecord::Base
  SUPER_ADMIN = "SuperAdmin"
  USER = "User"

  acts_as_authentic do |c|
    c.validate_email_field = false
    c.login_field = 'email'
  end
  
  include SearchHandler

	#For OmniAuth   
  has_many :authorizations, :dependent => :destroy
 
  def self.create_from_omniauth_data(omniauth_data)
    user = User.new(
      :first_name => omniauth_data['info']['name'].to_s.downcase,
      :email => omniauth_data['info']['email'].to_s.downcase#if present
      )
		user.role = Role.find_by(:role_type => USER)
    #user.omniauth_data = omniauth_data.to_json #shove OmniAuth::AuthHash as json data to be parsed later!
		user.is_active = true
    user.save(:validate => false) #create without validations because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end	

  attr_writer :password_required

	validates_presence_of :first_name
	validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates_presence_of :password, :if => :password_required?

  has_one :user_role, :dependent => :destroy
  has_one :role, :through => :user_role
  has_many :events
  has_many :contributors, :dependent => :destroy
  belongs_to :contributed
  has_many :comments
  has_many :carts
	has_many :wishes

  scope :all_users, joins(:role).where(:roles => { :role_type => USER })

  def password_required?
    @password_required
  end
	
 
  #birth date validation
  validates_inclusion_of :birth_date, :in=>Date.new(1900)..Time.now.years_ago(18).to_date, :message=>'You must be 18 years or older'

 
  validates :email, :term, :presence => true

  mount_uploader :image, ImageUploader

  def is_admin?
    has_role?(SUPER_ADMIN)
  end

  def is_user?
   has_role?(USER)
  end

  def name(shorten=true)
    unless first_name.nil? && last_name.nil? or first_name.empty? && last_name.empty?
      [first_name, last_name].join(" ")
    else
      shorten ? truncate(email, :omission => "..", :length => 20) : email
    end
  end
	
	def self.search(search)
 	  if search
    	find(:all, :conditions => ['first_name LIKE ?', "%#{search}%"])
  	else
    	find(:all)
  	end
  end

end
