class CreateProgressCards < ActiveRecord::Migration
  def change
    create_table :progress_cards do |t|
      t.string :trello_id
      t.string :list_id
      t.string :name
      t.datetime :start

      t.timestamps
    end
  end
end
