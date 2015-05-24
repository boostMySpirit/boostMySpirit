class ModifyEventTypeFromPeriodicEvents < ActiveRecord::Migration
  def up
    remove_column :periodic_events, :eventType
    add_column :periodic_events, :event_type, :integer
    PeriodicEvent.all.each{|pe|pe.update_column(:event_type, 0)}
  end
  def down
    remove_column :periodic_events, :event_type
    add_column :periodic_events, :eventType, :string
  end
end
