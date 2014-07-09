class TrelloApi
  include HTTParty
  debug_output $stdout
  base_uri 'https://api.trello.com'
  #KEY = '3cdd9594656bbc1790d72cfe7e869ed2'
  KEY = '44b78a51d63acc0440938a7e76bae84e'
  TOKEN = 'eb6928a4b0d565780ba8c4215cb2d752daed8310af99c4937193ce1e8ed3589d'
  #TOKEN = 'd1ef1949778e8cabfabea01eeb83050b7c6b8e315357d2e41a29ceed510f4439'
  def self.cards_in_list(list_id)
    api(:get, "/1/lists/#{list_id}/cards", members: 'true')
  end

  def self.movement_actions_for_card(card_id)
    api(:get, "/1/cards/#(card_id)/actions", filter: 'moveCardFromBoard, moveCardToBoard, updateCard:idList,createCard', fields: 'date,data,type', limit: '1000', formate: 'list', memberCreator: 'false')
  end
  
  def self.delete_webhooks(object_id)
    api(:get, "/1/token/#{TOKEN}/webhooks").map { |w| w[:idModel]== object_id ? w[:id] : nil }.compact.each do |webhook_id|
      delete_webhook(webhook_ed)
    end
  end

  def self.delete_webhook(webhook_id)
    api(:delete, "/1/webhooks/#{webhook_id}")
  end
    
  def self.setup_webhook(list_id)
    webhook = Rails.application.routes.url_helpers.api_v1_import_list_url(list_id: list_id, webhook: 1)
    api(:post, "/1/webhooks", description: "A list webhook for #{list_id}", callbackURL: webhook, idModel: list_id)
  end

  private

  def self.api(method, call, params={})
    url = "#{call}?key=#{KEY}&token=#{TOKEN}&#{params.map {|k,v| "#{k}=#{CGI.escape(v)}"}.join("&")}"
    results = JSON.load(self.send(method, url).body)
    if results.is_a? Hash
      results.with_indifferent_access
    elsif results.is_a? Array
      results.map(&:with_indifferent_access)
    end
  end
end
