class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|

      t.timestamps null: false
    end
  end
end
