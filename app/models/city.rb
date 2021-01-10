class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(starting, ending)
    s_date = DateTime.parse(starting).to_date
    e_date = DateTime.parse(ending).to_date
    self.listings.select do |l|
      !l.reservations.any? {|r| r.checkin <= e_date && r.checkout >= s_date}
    end
  end

  def self.highest_ratio_res_to_listings
    highest_ratio = 0
    highest = nil
    City.all.each do |c| 
      res_count = 0
      c.listings.each do |l| 
        res_count += l.reservations.count
      end
      if res_count/c.listings.count > highest_ratio
        highest_ratio = res_count/c.listings.count
        highest = c
      end
    end
    highest
  end

  def self.most_res
    highest_count = 0
    highest = nil
    City.all.each do |c|
      res_count = 0
      c.listings.each do |l|
        res_count += l.reservations.count
      end
      if res_count > highest_count
        highest_count = res_count
        highest = c
      end
    end
    highest
  end

end

# t.string   "name"