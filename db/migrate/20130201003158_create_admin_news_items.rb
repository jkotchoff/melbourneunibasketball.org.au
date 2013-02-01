class CreateAdminNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.string :title
      t.string :author
      t.text :synopsis
      t.text :article

      t.timestamps
    end
  end
end
