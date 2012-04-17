class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params[:id])

    @url = @survey.get_url_for_user(current_user)
  end
end
