# == Schema Information
#
# Table name: referrals
#
#  id               :bigint           not null, primary key
#  referral_code    :string(255)
#  used             :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  referred_user_id :integer
#
class Referral < ApplicationRecord
  def self.generate_referral
    Referral.create!(referral_code: SecureRandom.hex(4).upcase)
  end
end
