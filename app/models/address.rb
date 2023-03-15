class Address < ApplicationRecord
	validates :address_line_one, :address_line_two, :city, :state, :country, :pincode, presence: true
	validates :mobile_number, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Wrong format" }

	belongs_to :user
end
