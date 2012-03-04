class AddCodeToItem < ActiveRecord::Migration
  def change
    add_column :items, :code, :text
  end
end
