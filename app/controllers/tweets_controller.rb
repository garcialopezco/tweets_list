class TweetsController < ApplicationController
  def index
    @tweets = if params[:topic].present?
                TweetsQuery.search(params[:topic])
              else
                []
              end
  end
end
