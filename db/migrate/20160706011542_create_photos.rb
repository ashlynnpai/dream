class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :image
      t.text :caption
      t.string :owner
      t.string :copyright
      t.integer :place_id
      t.integer :user_id  
      t.timestamps
    end
    
    add_index :photos, :place_id
    add_index :photos, :user_id
  end
end
