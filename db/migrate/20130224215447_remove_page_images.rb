class RemovePageImages < ActiveRecord::Migration[4.2]
  def change
    remove_column :pages, :image
    remove_column :pages, :image_processing
  end
end
