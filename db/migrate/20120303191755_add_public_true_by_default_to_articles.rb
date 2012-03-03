class AddPublicTrueByDefaultToArticles < ActiveRecord::Migration
  def up
        change_column :articles, :public, :boolean, :default => true
  end

  def down
        change_column :articles, :public, :boolean, :default => nil
  end

end
