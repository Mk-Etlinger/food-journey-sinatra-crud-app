class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |table|
      table.string :name
    end
  end
end
