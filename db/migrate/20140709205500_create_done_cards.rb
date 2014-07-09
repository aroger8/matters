class CreateDoneCards < ActiveRecord::Migration
  def change
    create_table :done_cards do |t|
      t.string :trello_id
      t.string :list_id
      t.string :name
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
