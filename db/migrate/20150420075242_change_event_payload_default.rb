class ChangeEventPayloadDefault < ActiveRecord::Migration
  def change
    change_column_null :events, :payload, true
  end
end
