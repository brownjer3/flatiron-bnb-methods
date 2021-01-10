class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(starting, ending)
    s_date = DateTime.parse(starting).to_date
    e_date = DateTime.parse(ending).to_date
    self.listings.select do |l|
      !l.reservations.any? {|r| r.checkin <= e_date && r.checkout >= s_date}
    end
  end

  def self.highest_ratio_res_to_listings
    highest_ratio = 0
    highest = nil
    Neighborhood.all.each do |n| 
      res_count = 0
      n.listings.each do |l| 
        res_count += l.reservations.count
      end
      if res_count > 0 && res_count/n.listings.count > highest_ratio
        highest_ratio = res_count/n.listings.count
        highest = n
      end
    end
    highest
  end

  def self.most_res
    highest_count = 0
    highest = nil
    Neighborhood.all.each do |n|
      res_count = 0
      n.listings.each do |l|
        res_count += l.reservations.count
      end
      if res_count > highest_count
        highest_count = res_count
        highest = n
      end
    end
    highest
  end

end


# t.string   "name"
# t.integer  "city_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false