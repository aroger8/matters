class ProgressCard < ActiveRecord::Base
  def self.find_or_create(card_hash)
    progress_card = find_or_initialize_by_trello_id(
      card_hash[:id]
      name: card_hash[:name]
    )
    progress_card.save
    progress_card
  end
end
