require 'open-uri'

module Importers
  class DoneCards
    def self.import(trello_done_list_id)
      projects = TrelloApi.cards_in_list(trello_done_list_id) || []
      projects.each_with_index do |project_hash, index|
        project = Projects.find_or_create(project_hash)
      end
    end
  end
end
