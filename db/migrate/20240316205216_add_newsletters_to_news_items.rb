class AddNewslettersToNewsItems < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :newsletter, :string
  end
end
