class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :fname
      t.string :lname
      t.string :phone
      t.date :birth_date
      t.string :email
      t.references :user, null: false, foreign_key: true
      t.references :suburb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
