require 'csv'
class Hospital < ActiveRecord::Base
  geocoded_by :full_address
  after_validation :geocode, :if => :address_changed? || :city_changed? || :state_changed? || :zip_changed?

  def full_address
  	return self.address + ", " + self.city + " " + self.state + ", " + self.zip
  end

  def self.import(file)
	CSV.foreach(file, headers: true) do |row|
	    hospital = find_by_id(row["provider_id"]) || new
	    hospital.attributes = row.to_hash.slice(*Hospital.attribute_names())
	    if hospital.state == "IL" || hospital.state == "Illinois"
	    	hospital.save!
   		    sleep(0.2)
	    end
	  end
  end

end
