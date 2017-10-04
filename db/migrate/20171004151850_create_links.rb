class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :full_url
      t.string :short_url
      t.integer :clicks, :default => 0

      t.timestamps
    end
  end
end
