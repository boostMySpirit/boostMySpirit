class CreatePeriodicEvents < ActiveRecord::Migration
  def change
    create_table :periodic_events do |t|
      t.string :eventType
      t.datetime :start
      t.datetime :end
      t.integer :periodicity
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
