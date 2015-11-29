require 'geo-distance'
class MapController < ApplicationController
  def home
  end
  def hospitals_within
  	#return a json representation of hospitals within the given coordinates
  	lat1 = params[:lat1]
  	lat2 = params[:lat2]
  	lon1 = params[:lon1]
  	lon2 = params[:lon2]
  	n = 45
  	dist = GeoDistance::Haversine.geo_distance(lat1, lon1, lat2, lon2).to_meters / 1000
  	list = Hospital.near([(lat1.to_f + lat2.to_f) / 2.0, (lon1.to_f + lon2.to_f ) / 2.0], dist/ 3.0, :units => :km) 
  	final_list = list.sort_by{|e| e[:spending_score] * e[:performance_score]}.reverse[0..n]
  	render json: final_list
  end
end


