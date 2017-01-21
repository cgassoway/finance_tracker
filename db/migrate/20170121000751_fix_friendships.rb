class FixFriendships < ActiveRecord::Migration[5.0]
  def change
    change_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend, class: 'User'
    end
  end
end
