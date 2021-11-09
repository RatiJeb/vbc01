class AddUniqueIndexToProjects < ActiveRecord::Migration[6.1]
  def up
    add_index :projects, :title, unique: true
    change_column :projects, :title, :string, limit: 150
    change_column :projects, :format, :string, limit: 50
    add_column :projects, :active, :boolean, null: false, default: false
  end

  def down
    remove_index :projects, :title
    change_column :projects, :title, :string, limit: 255
    change_column :projects, :format, :string, limit: 255
    remove_column :projects, :active
  end
end
