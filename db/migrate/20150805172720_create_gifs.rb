class CreateGifs < ActiveRecord::Migration
  def up 
    create_table :gifs do |t|
      t.string :username
      t.string :url
    end
  end
    def down
      drop_table :gifs
    end
end
