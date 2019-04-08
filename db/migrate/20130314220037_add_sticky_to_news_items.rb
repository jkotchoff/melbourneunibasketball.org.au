class AddStickyToNewsItems < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :sticky, :boolean
    add_index :pages, :sticky
  end
end
