class AddPdfsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :pdf, :string
  end
end
