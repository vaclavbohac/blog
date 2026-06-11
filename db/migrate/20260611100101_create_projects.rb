class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :logo
      t.string :link, null: true

      t.timestamps
    end
  end
end
