class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |table|
      table.string :description
    end
  end
end
