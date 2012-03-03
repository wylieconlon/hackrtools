class RenameSnippetsDescriptionToTitle < ActiveRecord::Migration
  def up
    rename_column :snippets, :description, :title
  end

  def down
    rename_column :snippets, :title, :description
  end
end
