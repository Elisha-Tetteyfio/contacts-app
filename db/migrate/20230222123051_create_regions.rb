class CreateRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :regions do |t|
      t.string :name
      t.text :remark
      t.references :user, null: false, foreign_key: true

      t.timestamp :created_at, null: false
      t.timestamp :updated_at, null: true      
    end
  end
end
