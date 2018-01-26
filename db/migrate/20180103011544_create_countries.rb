class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.text :about
      t.integer :user_id
      t.text :visa_box
      t.string :slug
      t.string :video
      t.string :country_code
      t.boolean :selective

      t.timestamps null: false
    end

    add_index :countries, :slug, unique: true
  end

  def self.up
    change_table :countries do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :countries, :profile_pic
  end
end
