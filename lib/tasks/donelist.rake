task import_list: :environment do
  unless ENV['list_id']
    puts "the list_id argument is required; nothing was imported"
    exit 1
  end
  # Used only on done list
  Importers::DoneCards.import(ENV['list_id']) do |update|
    puts update
  end
end
