class AddDoorsToTaxi < ActiveRecord::Migration[6.0]
  def change
    add_column :taxis, :doors, :integer
  end
end

