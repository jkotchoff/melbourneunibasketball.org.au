class CreateContentImages < ActiveRecord::Migration[4.2]
  def change
    create_table :content_images do |t|
      t.references :page
      t.string :image
      t.date :created_at
    end
  end
end
