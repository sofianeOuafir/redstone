class AddCountryToPlaces < ActiveRecord::Migration[6.0]
  def change
    add_reference :places, :country, null: false, foreign_key: true
  end
end
