class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.text :description
      t.decimal :price
      t.datetime :event_date_time
      t.datetime :event_date_time_end
      t.string :slug      
      t.boolean :sticky
      
      t.timestamps null: false
    end
    
    add_index :events, :slug, unique: true

  end

  def self.up
    change_table :events do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :events, :cover
  end
end
