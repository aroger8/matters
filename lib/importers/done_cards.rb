require 'open-uri'

module Importers
  class DoneCards
    def self.import(trello_done_list_id)
      cards = TrelloApi.cards_in_list(trello_done_list_id) || []
      cards.each_with_index do |done_card_hash, index|
        # creates cards correctly
        done_card = DoneCard.find_or_create(done_card_hash)
	# try to parse out the date
	actions = TrelloApi.movement_actions_for_card(done_card.trello_id) || []
	actions.each do |action_hash|
          case action_hash[:type]
	  when 'updateCard'
	    done_card.start = Chronic.parse(action_hash[:date])
	    done_card.save
	  end
	end
	actions = TrelloApi.card_end(done_card.trello_id) || [] 
	date = Chronic.parse(actions[:dateLastActivity])
	done_card.end = date
        done_card.done = true
	done_card.save
      end
    end
  end
end
