class CreateSeries < ActiveRecord::Migration[8.1]
  def change
    create_table :series do |t|
      t.string :title
      t.text :perex
      t.integer :position

      t.timestamps
    end
  end
end
