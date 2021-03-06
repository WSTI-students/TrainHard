class TrainingsController < ApplicationController

  def index
    @trainings = current_user.trainings.all
  end

  def new
    @training = current_user.trainings.new
  end

  def show
    @training = current_user.trainings.find(params[:id])
  end

  def create
    current_user.training.create(trainings_params)
    redirect_to user_trainings_path(current_user)
  end

  def search; end

  def search_training
    if params[:training].blank?
      flash[:danger] = "Empty search string"
      render "search"
    else
      @training = Training.from_search(params[:training])
      if @training.blank?
        flash[:danger] = "No matching training"
        render "search"
      else
        render "result", locals: { training: @training }
      end
    end
  end

  private

  def trainings_params
    params.required(:training).permit(:name)
  end

end
