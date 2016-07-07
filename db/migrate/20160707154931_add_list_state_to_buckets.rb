class AddListStateToBuckets < ActiveRecord::Migration
  def change
    add_column :buckets, :list_state, :string
  end
end



