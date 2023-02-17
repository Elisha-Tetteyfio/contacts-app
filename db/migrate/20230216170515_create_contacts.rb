class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :f_name
      t.string :l_name
      t.string :number

      t.timestamps
    end
  end
end
