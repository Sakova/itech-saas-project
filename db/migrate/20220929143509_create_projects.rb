class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :details
      t.date :expected_completion_date
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
