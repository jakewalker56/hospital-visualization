class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :provider_id
      t.string :phone_number
      t.float :spending_score
      t.float :performance_score
      t.timestamps
    end
  end
end
