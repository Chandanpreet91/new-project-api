class AddUserReferencesTo < ActiveRecord::Migration[6.0]
  def change
    add_reference :drivers, :user, index: true
  end
end
