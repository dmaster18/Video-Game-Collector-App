class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :console_id
      t.integer :user_id
      t.string :genre, default: ""
      t.string :release_year, default: ""
      t.string :rating, default: ""
      t.string :developer, default: ""
      t.string :publisher, default: ""
      t.string :country, default: ""
    end
  end
end
