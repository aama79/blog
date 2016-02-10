class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title,  presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 25 }
	validates :cover, presence: true
	before_save :set_visits_count
	has_attached_file :cover, styles: { medium: "300x300>", thumb:"100×100>" }
	#validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
	validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png"]
	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		self.visits_count ||= 0
	end
end
