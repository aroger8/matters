class ProgressCard < ActiveRecord::Base
  def self.find_or_create(progress_card_hash)
    progress_card = find_or_initialize_by_trello_id(
      progress_card_hash[:id],
      name: progress_card_hash[:name]
    )
    progress_card.save
    progress_card
  end
end
