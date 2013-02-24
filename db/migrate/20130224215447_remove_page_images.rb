class RemovePageImages < ActiveRecord::Migration
  def change
    remove_column :pages, :image
    remove_column :pages, :image_processing
  end
end
