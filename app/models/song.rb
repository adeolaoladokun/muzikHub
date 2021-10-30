class Song < ApplicationRecord
#attr_accessor :business_name, :account_number,:percentage_charge,:settlement_bank,:currency,:subaccount_code,:is_verified,:active,:createdAt,:updatedAt,:user_id #attributes that can be mass-assinged

  has_many :transactions

end
