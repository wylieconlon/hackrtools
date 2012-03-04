class AddPublicBooleanToItem < ActiveRecord::Migration
  def change
    add_column :items, :public, :boolean, :default => true
  end
end
