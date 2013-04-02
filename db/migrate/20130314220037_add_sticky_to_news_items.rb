class AddStickyToNewsItems < ActiveRecord::Migration
  def change
    add_column :pages, :sticky, :boolean
    add_index :pages, :sticky
  end
end
