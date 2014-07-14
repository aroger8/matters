class AddIndexToDoneCards < ActiveRecord::Migration
  def change
    add_index :done_cards, :trello_id, unique: true
  end
end
