class AddDoneToDoneCards < ActiveRecord::Migration
  def change
    add_column :done_cards, :done, :boolean
  end
end
