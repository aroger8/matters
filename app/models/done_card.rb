class DoneCard < ActiveRecord::Base
  def self.find_or_create(card_hash)
    done_card = find_or_initialize_by_trello_id(
      card_hash[:id]
      name: card_hash[:name]
    )
    done_card.save
    done_card
  end
end
