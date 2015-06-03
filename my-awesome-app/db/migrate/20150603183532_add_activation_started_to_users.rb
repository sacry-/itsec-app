class AddActivationStartedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_started, :datetime
  end
end
