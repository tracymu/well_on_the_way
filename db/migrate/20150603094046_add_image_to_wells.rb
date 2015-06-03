class AddImageToWells < ActiveRecord::Migration
  def change
    add_column :wells, :image, :string
  end
end
