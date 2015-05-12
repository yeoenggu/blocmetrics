class RemoveConfirmableFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :confirmation_token, :confirmed_at, :confirmation_sent_at,  :unconfirmed_email
    end
  end
end
