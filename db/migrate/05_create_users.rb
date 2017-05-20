class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |table|
      table.string :username
      table.string :email
      table.string :password_digest
    end
  end
end
