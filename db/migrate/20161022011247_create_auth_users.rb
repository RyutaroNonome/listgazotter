class CreateAuthUsers < ActiveRecord::Migration
  def change
    create_table :auth_users do |t|
      t.string :provider, :null => false, :limit => 16
      t.string :uid, :null => false
      t.string :name
      t.string :credentials
      t.text   :user_info_raw

      t.timestamps
    end

    add_index :auth_users, [:provider, :uid], :unique => true
  end
end