class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :name
      t.string :url
      t.datetime :last_synch_at
      t.timestamps
    end
  end
end
