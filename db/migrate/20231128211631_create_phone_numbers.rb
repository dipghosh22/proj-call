class CreatePhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :phone_numbers do |t|
      t.primary_key :id
      t.string :number
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
