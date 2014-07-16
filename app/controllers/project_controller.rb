class ProjectController < ApplicationController
  def show
    @done_card = DoneCard.all
  end

  def about
  end
end
