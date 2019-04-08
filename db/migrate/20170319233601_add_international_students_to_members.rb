class AddInternationalStudentsToMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :international_student, :boolean, default: false
    add_column :members, :availability, :string
  end
end
