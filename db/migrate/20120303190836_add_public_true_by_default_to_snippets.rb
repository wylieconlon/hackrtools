class AddPublicTrueByDefaultToSnippets < ActiveRecord::Migration
  def up
        change_column :snippets, :public, :boolean, :default => true
  end

  def down
        change_column :snippets, :public, :boolean, :default => nil
  end
end
