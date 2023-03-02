class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.string :role_code
      t.boolean :active_status, default: true
      t.boolean :del_status, default: false

      t.timestamps
    end
  end
end
