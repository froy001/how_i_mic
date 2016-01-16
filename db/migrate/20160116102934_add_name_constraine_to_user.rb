class AddNameConstraineToUser < ActiveRecord::Migration
   MISSING_VALUE_PLACEHOLDER = '<missing>'

  def up
    change_column_null :users, :name, false, MISSING_VALUE_PLACEHOLDER
  end

  def down
    change_column_null :users, :name, true
    execute "UPDATE widgets SET name = NULL WHERE name = #{MISSING_VALUE_PLACEHOLDER}"
  end
end
