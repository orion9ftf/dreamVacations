class ChangeNameColumnType < ActiveRecord::Migration[6.1]
  def change
    rename_column :vacations, :type, :type_vacation
  end
end
