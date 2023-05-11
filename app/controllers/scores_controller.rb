# frozen_string_literal: true

class ScoresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  # GET /lessons/new
  def new
    @score = current_user.scores.new
  end

  # POST /lessons or /lessons.json
  def create
    @score = current_user.scores.new(score_params)
    @score.course = @course
    print("\n\n\n\n\n\n #{@score} \n\n\n\n\n\n")
    respond_to do |format|
      if @score.save
        format.html { redirect_to course_path(@course), notice: 'Calificación guardada correctamente' }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def score_params
    params.require(:score).permit(:value, :description, :course_id, :user_id)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
