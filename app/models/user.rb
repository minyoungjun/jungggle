require "open-uri"
require 'rest_client'
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
  has_many  :usernotis


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

  def self.send_confirmation_email(id)
    user = User.find(id)
    user.confirmation_token = SecureRandom.hex(15)
    RestClient.post "https://api:key-d9dd9c0e53befa87a8e213df42ba5da0"\
      "@api.mailgun.net/v2/jungggle.com/messages",
      :from => "Jungggle <admin@jungggle.com>",
      :to => user.email,
      :subject => "[Jungggle] Please confirm your e-mail address",
      :html => "<h1>Welcome to Jungggle!</h1><p style='line-height: 23px; font-size: 15px; font-weight: 400;'>Thanks again for joining us, the best way to buy & sell marketing service. <br><br>Your account is ready to go.<br>Email: #{user.email}<br><br>Please confirm your e-mail address to protect our relationship with you.</p><a href='http://jungggle.com/confirmation/#{user.id}?token=#{user.confirmation_token}'>http://jungggle.com/confirmation/#{user.id}?token=#{user.confirmation_token}</a><br><br><br><h4 style='font-size: 16px; line-height: 23px;'>Thanks for your support!<br>Team Jungggle</h4><img src='http://jungggle.com/assets/main/header-logo.png'/>"
    user.confirmation_sent_at = Time.now
    user.save
  end

  def send_welcome_email
    user = self
    RestClient.post "https://api:key-d9dd9c0e53befa87a8e213df42ba5da0"\
      "@api.mailgun.net/v2/jungggle.com/messages",
      :from => "Jungggle <admin@jungggle.com>",
      :to => user.email,
      :subject => "Welcome to Jungggle!",
      :html => "<h1>Thank you for joining Jungggle!<h1><p style='line-height: 23px; font-size: 14px; font-weight: 400; margin-top: 12px;'>We are excited to welcome you to Jungggle and are looking forward to a successful partnership. <br> Jungggle allows you to find the right solutions for your business to buy and sell marketing services. For advertisers, Jungggle collects and organizes data from marketing companies around the globe. Through Jungggle's filtering mechanism, you can easily find local marketing companies that suit your needs. For service providers, you can now conduct direct sales not only to your local client but also to global clients. You no longer have to exchange countless emails to provide detailed information.</p><br><h4 style='line-height: 23px;'>Discover <span style='text-decoration: underline;'>Jungggle</span><Br>Continue to explore the website and get started right away!<br>Questions? Contact <a href='http://jungggle.com'>Jungggle</a></h4><br><br><h4 style='line-height:23px; font-size: 15px;'>Best,<br>Team Jungggle</h4><img src='http://jungggle.com/assets/main/header-logo.png'/>"
  end

  def user_notify(id)
    
    if self.usernotis.where(:notification_id => id, :is_deleted => false).count == 0
      usernoti = Usernoti.new
      usernoti.user_id = self.id
      usernoti.notification_id = id

      case id
      when 1
        usernoti.content = "Please confirm your email address, a confirm mail was sent to #{self.email} <a href='/users/reconfirm'><span class='underline'>resend confirmation</span></a>"
      when 2
        usernoti.content = "The confirm message is resent to #{self.email}"
      when 3
        usernoti.content = "Please complete company profile, first."
      when 4
        usernoti.content = "Your account has been updated"
      when 5
        usernoti.content = "Please complete your profile, first."
      when 6
        usernoti.content = "You can manage your Service after your company(#{self.member.company.comlangs.first.name}) approve you."
      end
      usernoti.is_deleted = false
      usernoti.save
    end

  end


end
