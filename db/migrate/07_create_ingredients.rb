class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |table|
      table.string :name
    end
  end
end
