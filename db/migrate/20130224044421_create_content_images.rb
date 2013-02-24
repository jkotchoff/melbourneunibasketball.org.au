class CreateContentImages < ActiveRecord::Migration
  def change
    create_table :content_images do |t|
      t.references :page
      t.string :image
      t.date :created_at
    end
  end
end
