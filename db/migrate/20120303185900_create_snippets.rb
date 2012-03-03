class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :description
      t.string :link
      t.text :code
      t.boolean :public

      t.timestamps
    end
  end
end
