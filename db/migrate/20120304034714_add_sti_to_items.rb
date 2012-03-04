class AddStiToItems < ActiveRecord::Migration
  def up
    add_column :items, :type, :string
  end

  def down
    remove_column :items, :type
  end
end
