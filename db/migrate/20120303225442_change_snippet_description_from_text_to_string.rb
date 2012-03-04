class ChangeSnippetDescriptionFromTextToString < ActiveRecord::Migration
  def up
    change_column :snippets, :title, :string
  end

  def down
    change_column :snippets, :title, :text
  end
end
