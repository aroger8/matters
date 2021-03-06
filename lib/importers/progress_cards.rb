require 'open-uri'

module Importers
  class ProgressCards
    def self.import(trello_progress_list_id)
      cards = TrelloApi.cards_in_list(trello_progress_list_id) || []
      cards.each_with_index do |progress_card_hash, index|
        progress_card = DoneCard.find_or_create(progress_card_hash)
	progress_card.done = false
        progress_card.save
	actions = TrelloApi.movement_actions_for_card(progress_card.trello_id) || []
	actions.each do |action_hash|
          case action_hash[:type]
          when 'updateCard'
            progress_card.start = Chronic.parse(action_hash[:date])
            progress_card.save
          end
        end
      end
    end
  end
end
