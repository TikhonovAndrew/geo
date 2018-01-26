class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.string :name
      t.text :body
      t.string :school
      t.string :category
           
      t.timestamps null: false
    end
  end

  def self.up
    change_table :testimonials do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :testimonials, :profile_pic
  end
end
