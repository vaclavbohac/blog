class CreateWorkExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :work_experiences do |t|
      t.string :company
      t.string :role
      t.string :logo
      t.date :started_on
      t.date :ended_on

      t.timestamps
    end
  end
end
