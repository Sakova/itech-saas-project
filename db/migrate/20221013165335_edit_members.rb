class EditMembers < ActiveRecord::Migration[6.1]
  def change
    remove_column :members, :first_name
    remove_column :members, :last_name
    remove_index :members, name: "index_members_on_organization_id"
    remove_column :members, :organization_id
    add_reference :members, :project, foreign_key: true
  end
end
