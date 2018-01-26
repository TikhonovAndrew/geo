class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.belongs_to :school, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
