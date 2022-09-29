class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.integer :plan, null: false, default: 0

      t.timestamps
    end
  end
end
