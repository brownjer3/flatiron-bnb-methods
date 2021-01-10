class Reservation < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with DateValidator

  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true
  validates :guest, exclusion: { in: ->(reservation) { [reservation.listing.host] } }
  
  def duration
    (self.checkout - self.checkin).to_i
  end

  def total_price
    self.listing.price * duration
  end 

end


# t.date     "checkin"
# t.date     "checkout"
# t.integer  "listing_id"
# t.integer  "guest_id"
# t.datetime "created_at",                     null: false
# t.datetime "updated_at",                     null: false
# t.string   "status",     default: "pending"