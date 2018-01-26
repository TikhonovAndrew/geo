class CreateTeamMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :phone
      t.string :position
      t.integer :rank
      t.string :category
      t.string :slug

      t.timestamps
    end
    
    add_index :team_members, :slug, unique: true
  end

  def self.up
    change_table :team_members do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :team_members, :profile_pic
  end
end
