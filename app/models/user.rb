require "open-uri"
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, 
        :recoverable, :rememberable, :trackable, :validatable, :omniauthable
   TEMP_EMAIL_PREFIX = 'change@me'
   TEMP_EMAIL_REGEX = /\Achange@me/


  validates :avatar,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 5.megabytes }

  has_attached_file :avatar, styles: {
    thumb: '52x52#',
    square: '200x200#',
    medium: '300x300>'
  }
  has_one :member
  has_many :carts
  has_many  :products
  has_many  :billings
  has_many  :biddings
  has_many  :identities


validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def avatar_from_url(url)
    self.avatar = open(url)
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      puts auth
      email = auth.info.email
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        puts "-------"
        puts auth
        user = User.new(
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )

        if auth.provider == "linkedin"
          user.avatar_from_url auth.extra.raw_info.pictureUrl
        end
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

end
