class AddColumnDriverToTaxi < ActiveRecord::Migration[6.0]
  def change
    add_column :taxis, :driver, :string
  end
end
