class Api::V1::ImporterController < ApplicationController
  include ActionController::Live
  skip_before_filter :verify_authenticity_token

  def create
    response.headers['Content-Type'] = 'text/event-stream'
    result = if params[:list_id]
      if params[:autoupdate] == 'true'
        Rails.application.routes.default_url_options[:host] = request.host
        TrelloApi.setup_webhook(params[:list_id])
        response.stream.write "Setup webhook for #{params[:list_id]}"
      else
        Rails.logger.error params.inspect
        response.stream.write "Importing....\n"
        Importers::CompletedCards.import(params[:list_id]) do |c|
          response.stream.write "Progress: #{c}%\n"
        end
      end
       true
     else
       false
     end
     response.stream.close
     render json: {success: result }
   end
 end
