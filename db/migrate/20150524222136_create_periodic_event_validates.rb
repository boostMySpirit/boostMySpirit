class CreatePeriodicEventValidates < ActiveRecord::Migration
  def change
    create_table :periodic_event_validates do |t|
      t.references :periodic_event, index: true, foreign_key: true
      t.date :date

      t.timestamps null: false
    end
  end
end
