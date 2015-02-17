class AddDribblingBallsLinksToPages < ActiveRecord::Migration
  def change
    add_column :pages, :dribbling_balls_link, :string
  end
end
