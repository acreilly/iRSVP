class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :title
      t.string :location
      t.string :latitude
      t.string :longitude
      t.string :description
      t.datetime :event_start
      t.datetime :event_finish
      t.timestamps
    end
  end
end
