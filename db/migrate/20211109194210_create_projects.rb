class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title, length: { maximum:150 }
      t.string :format, length: { maximum:50 }
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
