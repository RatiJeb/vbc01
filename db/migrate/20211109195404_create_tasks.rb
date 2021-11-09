class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title, null: false
      t.boolean :done, null: false, default: false
      t.string :tags, array: true, default: []

      t.timestamps
    end
  end
end
