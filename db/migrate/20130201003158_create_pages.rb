class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :type
      t.string :title
      t.string :author
      t.text :synopsis
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
