class DateValidator < ActiveModel::Validator

  # Ensure that the date given is in MM/DD/YYYY format.
  # Also ensure that the date is not a past date
  def validate(record)
    date_split = record.requested_date.split("/")
    if (date_split.length != 3)
      record.errors[:requested_date] << "must be specified in the format MM/DD/YYYY"
    else
      if ((date_split[0].to_i < 1) || (date_split[0].to_i > 12) || (date_split[0].length != 2))
        record.errors[:requested_date] << "must have a valid month (01 to 12)"
      elsif ((date_split[1].to_i < 1) || (date_split[0].to_i > 31) || (date_split[1].length != 2))
        record.errors[:requested_date] << "must have a valid day (01 to 31)"
      elsif (date_split[2].length != 4)
        record.errors[:requested_date] << "must be specified in the format MM/DD/YYYY"
      else
        time_now = Time.now
        if (date_split[2].to_i < time_now.year)
          record.errors[:requested_date] << "must not be a past date"
        elsif (date_split[2].to_i == time_now.year)
          if(date_split[0].to_i < time_now.month)
            record.errors[:requested_date] << "must not be a past date"
          elsif (date_split[0].to_i == time_now.month)
            unless (date_split[1].to_i >= time_now.day)
              record.errors[:requested_date] << "must not be a past date"
            end
          end
        end
      end
    end
  end

end
