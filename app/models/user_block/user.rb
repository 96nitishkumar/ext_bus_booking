module UserBlock
	class User < ApplicationRecord
		self.table_name = :user_block_users

		has_secure_password
		has_many :bookings, class_name: "BookingBlock::Booking"
		validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
		validates :name, presence: true
		validates :password, presence: true, length: { in: 6..14 }
	end
end
