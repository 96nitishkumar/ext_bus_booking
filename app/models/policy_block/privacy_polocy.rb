module PolicyBlock

	class PrivacyPolocy < ApplicationRecord

		self.table_name = :policy_block_privacy_polocies
		has_many_attached :images

		# validates :images, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes }
		validates :title, :description, presence: true
		before_validation :check_policy_count
		validate :check_image_count

		def self.ransackable_attributes(auth_object = nil)
	    	["created_at", "description", "id", "title", "updated_at"]
	  end

    def check_image_count
      if images.attached? && images.length > 3
        errors.add(:images, "You cannot select more than three images")
      end
    end

		def check_policy_count
		 		errors.add(:title, "You can not create more than two policy") if PolicyBlock::PrivacyPolocy.count == 2
		end

	end

end
