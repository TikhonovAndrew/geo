class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.integer :user_id
      t.string :name
      t.text :about
      t.text :summary
      t.string :slug
      t.string :video
      t.string :category
      t.string :link

      t.timestamps null: false
    end

    add_index :schools, :slug, unique: true
    add_reference :schools, :country, index: true, foreign_key: true
  end

  def self.up
    change_table :schools do |t|
      t.attachment :cover_pic
    end
  end

  def self.down
    remove_attachment :schools, :cover_pic
  end
end
