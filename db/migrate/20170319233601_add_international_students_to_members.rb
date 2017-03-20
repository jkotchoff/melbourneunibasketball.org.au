class AddInternationalStudentsToMembers < ActiveRecord::Migration
  def change
    add_column :members, :international_student, :boolean, default: false
    add_column :members, :availability, :string
  end
end
