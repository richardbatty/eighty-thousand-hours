class SurveysController < ApplicationController
  load_and_authorize_resource

  def show
    @survey = Survey.find(params[:id])

    @url = @survey.get_url_for_user(current_user)
  end
end
