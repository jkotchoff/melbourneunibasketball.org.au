class AddUrlSlugsToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :slug, :string
    add_index :pages, :slug, unique: true
  end
end
