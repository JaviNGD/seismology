class CreateData < ActiveRecord::Migration[7.1]
  def change
    create_table :data do |t|
      t.string :external_id
      t.decimal :magnitude
      t.string :place, null: false
      t.string :time
      t.boolean :tsunami
      t.string :mag_type, null: false
      t.string :title, null: false
      t.decimal :longitude, null: false
      t.decimal :latitude, null: false
      t.string :url, null: false

      # Constraints for the data
      t.check_constraint 'magnitude >= -1.0 AND magnitude <= 10.0', name: 'magnitude_range_check'
      t.check_constraint 'latitude >= -90.0 AND latitude <= 90.0', name: 'latitude_range_check'
      t.check_constraint 'longitude >= -180.0 AND longitude <= 180.0', name: 'longitude_range_check'

      t.timestamps
    end
    add_index :data, :external_id, unique: true
  end
end
