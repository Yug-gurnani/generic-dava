# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :text(65535)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  image_url              :string(255)      default("")
#  jti                    :string(255)
#  name                   :string(255)      default("")
#  phone_number           :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  user_type              :integer          default("user")
#  verified               :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  google_id              :string(255)      default("")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum user_type: %i[user admin]
  has_one :cart

  after_create :create_cart

  def create_cart
    Cart.create!(user_id: id)
  end

  def cart_details
    products = cart.product_cart_mappings.pluck(:product_id, :quantity)
    data = []
    products.each do |product|
      product_id = product[0]
      product_quantity = product[1]
      product_attributes = Product.find_by_id(product_id).attributes

      data << { product_details: product_attributes, product_quantity: product_quantity }
    end
    data
  end

  def self.fetch_google_user(code, google_id)
    user_details = fetch_google_user_details(code)
    return if user_details.nil?

    create_google_user(user_details, google_id, referral_code)
  end

  def self.fetch_google_user_details(code)
    url = URI("https://oauth2.googleapis.com/tokeninfo?id_token=#{code}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    response = https.request(request)
    JSON(response.read_body)
  end

  def self.create_google_user(user_details, googleId, _referral_code = '')
    email = user_details['email']
    name = user_details['name']
    user = User.where(email: email).first
    avatar = nil
    avatar = user_details['picture'] if user_details['picture'].present?
    if user.present?
      user.update(google_id: google_id)
      return user
    end

    User.create(
      name: name,
      email: email,
      password: Devise.friendly_token[0, 20],
      image_url: avatar,
      google_id: google_id,
    )
  end
end
