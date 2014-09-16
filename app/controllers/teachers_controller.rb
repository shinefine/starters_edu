class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # GET /teachers/new
  def new
    @teacher = Teacher.new
    @teacher.user =User.new
  end

  # GET /teachers/1/edit
  def edit
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)


      if @teacher.save
        redirect_to teachers_url, notice: '讲师已创建.'

      else
        render :new

      end

  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update

      if @teacher.update(teacher_params)
         redirect_to teachers_url, notice: '讲师信息已保存.'

      else
         render :edit

      end

  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy

    redirect_to teachers_url, notice: '讲师已删除.'


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(  user_attributes: [:name,:card_number,:phone_number])
    end
end
