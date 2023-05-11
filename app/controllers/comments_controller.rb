# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: %i[create]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to course_lesson_url(@lesson.course.id, @lesson) }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html do
          redirect_to course_lesson_url(@lesson.course.id, @lesson), notice: 'Problemas al dejar el comentario'
        end
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to course_lesson_url(@lesson.course.id, @lesson) }
      format.json { head :no_content }
    end
  end

  private

  def set_lesson
    @lesson = Lesson.where(id: params[:comment][:lesson_id]).first
  end

  def set_comment
    @comment = Comment.find(params[:id])
    @lesson = @comment.lesson
  end

  def comment_params
    params.require(:comment).permit(:content, :lesson_id)
  end
end
