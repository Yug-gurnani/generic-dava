class AddReferralTable < ActiveRecord::Migration[6.0]
  def change
    create_table :referrals do |t|
      t.boolean :used, default: false
      t.integer :referred_user_id
      t.string :referral_code, unique: true
      t.timestamps
    end
  end
end
