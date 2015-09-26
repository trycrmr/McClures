class AddPoliticiansToFavorite < ActiveRecord::Migration
  def change
    add_reference :favorites, :politician, index: true, foreign_key: true
  end
end
