class DropProgressCards < ActiveRecord::Migration
  def up
    drop_table :progress_cards
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
