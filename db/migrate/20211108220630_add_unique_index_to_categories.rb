class AddUniqueIndexToCategories < ActiveRecord::Migration[6.1]
  def up
    add_index :categories, :title, unique: true, where: "active IS TRUE"
  end
  def down
    remove_index :categories, :title
  end
end
