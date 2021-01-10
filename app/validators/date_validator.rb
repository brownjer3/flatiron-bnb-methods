class DateValidator < ActiveModel::Validator
    def validate(record)
        if record.checkin.nil? 
            record.errors[:checkin] << "Must provide checkin date"
        elsif record.checkout.nil?
            record.errors[:checkout] << "Must provide checkout date"
        elsif record.checkin >= record.checkout
            record.errors[:checkin] << "Checkin must be after checkout"
        else
            record.listing.reservations.each do |res|
                if record.checkin >= res.checkin && record.checkin <= res.checkout
                    record.errors[:checkin] << "Checkin date is unavailable"
                elsif record.checkout >= res.checkin && record.checkout <= res.checkout
                    record.errors[:checkout] << "Checkout date is unavailable"
                end
            end
        end
    end
end