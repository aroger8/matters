class DoneCard < ActiveRecord::Base
  def self.find_or_create(done_card_hash)
    done_card = find_or_initialize_by_trello_id(
      done_card_hash[:id],
      name: done_card_hash[:name]
    )
    done_card.save
    done_card
  end
end
