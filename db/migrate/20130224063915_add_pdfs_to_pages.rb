class AddPdfsToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :pdf, :string
  end
end
