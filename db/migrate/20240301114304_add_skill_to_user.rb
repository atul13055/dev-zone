class AddSkillToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :skills, :string, array: true, default: []
  end
end
