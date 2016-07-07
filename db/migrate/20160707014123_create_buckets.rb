class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.integer :position
      t.integer :place_id, :user_id
      t.timestamps 
    end
  end
end
