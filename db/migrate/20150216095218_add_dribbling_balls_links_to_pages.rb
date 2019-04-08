class AddDribblingBallsLinksToPages < ActiveRecord::Migration[4.2]
  def change
    add_column :pages, :dribbling_balls_link, :string
  end
end
