class ModifyGifs < ActiveRecord::Migration
  def up
    add_column :gifs, :user_id, :integer
    remove_column :gifs, :username, :string
  end
  def down
    remove_column :gifs, :user_id, :integer
    add_column :gifs, :username, :string
  end
end
