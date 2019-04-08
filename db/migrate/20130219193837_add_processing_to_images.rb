class AddProcessingToImages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :image_processing, :boolean
    add_column :members, :photo_processing, :boolean
  end
end
