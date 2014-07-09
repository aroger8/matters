require 'open-uri'

module Importers
  class ProgressCards
    def self.import(trello_progress_list_id)
      cards = TrelloApi.cards_in_list(trello_progress_list_id) || []
      cards.each_with_index do |progress_card_hash, index|
        progress_card = ProgressCard.find_or_create(progress_card_hash)
      end
    end
  end
end
