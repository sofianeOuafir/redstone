class AddLatLngToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_column :places, :lat, :float, { precision: 10, scale: 6 }
    add_column :places, :lng, :float, { precision: 10, scale: 6 }
  end
end
