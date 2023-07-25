class Update < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :passord_digst, :string
  end
end
