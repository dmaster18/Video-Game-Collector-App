class CreateConsoles < ActiveRecord::Migration[5.0]
  def change
    create_table :consoles do |t|
      t.string :name
      t.string :company
      t.integer :user_id
      t.string :release_year, default: ""
      t.string :generation, default: ""
      t.string :country, default: ""
      t.string :launch_price, default: ""
      t.string :units_sold, default: ""
    end
  end
end
