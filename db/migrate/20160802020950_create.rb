class Create < ActiveRecord::Migration
  def change
    create_table :place_categories do |t|
      t.integer :category_id, :place_id
    end
  end
end
