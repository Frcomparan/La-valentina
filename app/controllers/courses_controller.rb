# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_courses, only: %i[index admin_courses my_courses]
  before_action :create_sesion, only: %i[show]
  load_and_authorize_resource


  # GET /courses or /courses.json
  def index

  end

  def admin_courses

  end

  def my_courses

  end

  # GET /courses/1 or /courses/1.json
  def show; end

  # GET /courses/new
  def new
    @course = current_user.courses.new
  end

  # GET /courses/1/edit
  def edit; end

  # POST /courses or /courses.json
  def create
    @course = current_user.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: 'Curso creado correctamente' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to course_url(@course), notice: 'Curso actualizado correctamente' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Curso eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:name, :description, :price, :cover)
  end

  def set_courses
    if !params[:search].nil?
      @courses = Course.search(params[:search])
    else
      @courses = Course.all
    end
  end

  def create_sesion
    return unless user_signed_in?

    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    @checkout_session = current_user
      .payment_processor
      .checkout(
        mode: 'payment',
        line_items: [
          {
            price_data: {
              currency: 'mxn',
              unit_amount: (@course.price * 100).to_i,
              product_data: {
                name: @course.name,
                description: @course.description
              },
            },
            quantity: 1
          }
      ],
        success_url: checkout_success_url
      )
  end
end
