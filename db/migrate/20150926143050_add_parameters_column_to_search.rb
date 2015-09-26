class AddParametersColumnToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :parameters, :text
  end
end
