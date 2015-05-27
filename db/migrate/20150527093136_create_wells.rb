class CreateWells < ActiveRecord::Migration
  def change
    create_table :wells do |t|
      t.float :latitude
      t.float :longitude
      t.string :suburb
      t.string :postcode
      t.string :country
      t.string :description

      t.timestamps
    end
  end
end
