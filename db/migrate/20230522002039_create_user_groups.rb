class CreateUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups do |t|
      t.reference :user, foreign_key: true
      t.reference :group, foreign_key: true

      t.timestamps
    end
  end
end
