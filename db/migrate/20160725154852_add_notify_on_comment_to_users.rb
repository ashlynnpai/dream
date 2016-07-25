class AddNotifyOnCommentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_on_comment, :boolean, default: false
  end
end

