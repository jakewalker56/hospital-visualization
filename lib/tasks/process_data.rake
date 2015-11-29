desc "recreate hospitals"
task :recreate_hospitals => :environment do
  Hospital.destroy_all
  #now read from csv
  asset = Rails.application.assets.find_asset ("hospital_summary.csv")
      
  errors = Hospital.import(asset.pathname.to_s)
  if errors.present?
    error_string = ""
    errors.each do |error|
      error_string += error + '<br/>'
    end
    puts error_string
  end
end