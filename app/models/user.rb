class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  

  def guests
    listings.map do |l|
      l.guests
    end.flatten
  end

  def hosts
    trips.map do |t| 
      t.listing.host
    end.flatten
  end

  def host_reviews
    listings.map do |l|
      l.reviews
    end.flatten
  end

end

# t.string   "name"
# t.datetime "created_at",                 null: false
# t.datetime "updated_at",                 null: false
# t.boolean  "host",       default: false