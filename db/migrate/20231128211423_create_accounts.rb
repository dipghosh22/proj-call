class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.primary_key :id
      t.string :auth_id
      t.string :user_name

      t.timestamps
    end
  end
end
