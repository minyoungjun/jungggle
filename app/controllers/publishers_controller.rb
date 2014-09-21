class PublishersController < ApplicationController

  def create
    @languages = Language.all



  end
end
