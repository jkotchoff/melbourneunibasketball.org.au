class AddProcessingToImages < ActiveRecord::Migration
  def change
    add_column :pages, :image_processing, :boolean
    add_column :members, :photo_processing, :boolean
  end
end
