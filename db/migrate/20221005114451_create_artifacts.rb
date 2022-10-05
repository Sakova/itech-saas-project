class CreateArtifacts < ActiveRecord::Migration[6.1]
  def change
    create_table :artifacts do |t|
      t.string :name
      t.string :key
      t.integer :project_id

      t.timestamps
    end
  end
end
