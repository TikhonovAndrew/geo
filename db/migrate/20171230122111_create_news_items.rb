class CreateNewsItems < ActiveRecord::Migration[5.0]
  def change
    create_table :news_items do |t|
      t.string :title
      t.text :contect
      t.string :slug

      t.timestamps null: false
    end
    
    add_index :news_items, :slug, unique: true
  end

  def self.up
    change_table :news_items do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :news_items, :cover
  end
end
