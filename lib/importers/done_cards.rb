require 'open-uri'

module Importers
  class DoneCards
    def self.import(trello_done_list_id)
      cards = TrelloApi.cards_in_list(trello_done_list_id) || []
      cards.each_with_index do |done_card_hash, index|
        done_card = DoneCard.find_or_create(done_card_hash)
      end
    end
  end
end
