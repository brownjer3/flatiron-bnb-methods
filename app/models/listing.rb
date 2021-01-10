class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood_id, presence: true

  before_create :make_user_host
  before_destroy :make_user_non_host

  def average_review_rating
    (self.reviews.collect {|r| r.rating}.sum.to_f / self.reviews.count)
  end
  
  private
  def make_user_host
    self.host.update(host: true)
  end

  def make_user_non_host
    if self.host.listings.count == 1
      self.host.update(host: false)
    end
  end
end


# t.string   "address"
# t.string   "listing_type"
# t.string   "title"
# t.text     "description"
# t.decimal  "price",           precision: 8, scale: 2
# t.integer  "neighborhood_id"
# t.integer  "host_id"