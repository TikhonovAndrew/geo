class CreateFairs < ActiveRecord::Migration[5.0]
  def change
    create_table :fairs do |t|
      t.string :name
      t.string :location
      t.text :description
      t.decimal :price
      t.datetime :fair_date_time
      t.datetime :fair_date_time_end
      t.boolean :sticky
      t.string :slug
      
      t.timestamps
    end
  
    add_index :fairs, :slug, unique: true
  end

  def self.up
    change_table :fairs do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :fairs, :cover
  end
end
