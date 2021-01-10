class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :description, presence: true
  validates :rating, presence: true

  validate :valid_review

  private
  def valid_review
    if self.reservation.nil?
      errors.add :reservation, "Not a valid review"
    elsif self.reservation.checkout > Date.today
      errors.add :reservation, "Can only review reservations that have ended"
    end
  end

end


# t.text     "description"
# t.integer  "rating"
# t.integer  "guest_id"
# t.integer  "reservation_id"
# t.datetime "created_at",     null: false
# t.datetime "updated_at",     null: false