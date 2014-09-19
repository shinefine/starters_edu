class HomeworksController < ApplicationController
  before_action :set_training_class
  before_action :set_homework, only: [:show, :edit, :update, :destroy]


  # GET /homeworks
  # GET /homeworks.json
  def index
    @homeworks = @training_class.homeworks

  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
  end

  # GET /homeworks/new
  def new
    @homework = Homework.new
    @homework.subject_type =params[:subject]

    @homework.distribution_date = Time.now
    @homework.submit_date =1.days.from_now


  end

  # GET /homeworks/1/edit
  def edit
    @homework.need_set_finish_status = params[:set_finish_status]
  end

  # POST /homeworks
  # POST /homeworks.json
  def create

    @homework = @training_class.homeworks.build(homework_params)
    if(current_user.teacher?)
      @homework.teacher = current_user.teacher
    else #班主任创建作业时,自动设置其对应的讲师
      @homework.teacher =@training_class.sat_cr_teachers.first if   @homework.subject_type =='[sat]语法'
      @homework.teacher =@training_class.sat_math_teachers.first if  @homework.subject_type =='[sat]数学'
      @homework.teacher =@training_class.sat_write_teachers.first if  @homework.subject_type =='[sat]写作'
      @homework.teacher =@training_class.toefl_listen_teachers.first if  @homework.subject_type=='toefl_listen'
      @homework.teacher =@training_class.toefl_talk_teachers.first if  @homework.subject_type =='toefl_talk'
      @homework.teacher =@training_class.toefl_read_teachers.first if  @homework.subject_type =='toefl_read'
      @homework.teacher =@training_class.toefl_write_teachers.first if  @homework.subject_type=='toefl_write'

    end


      if @homework.save
        redirect_to  training_class_homeworks_path(@training_class), notice: '作业已创建.'

      else
        render :new

      end

  end

  # PATCH/PUT /homeworks/1
  # PATCH/PUT /homeworks/1.json
  def update
    @homework.students=Student.where(id: params[:homework][:student_ids])

      if @homework.update(homework_params)
        redirect_to training_class_homeworks_path(@training_class), notice: '作业信息已保存'

      else
        render :edit

      end

  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework.destroy

    redirect_to training_class_homeworks_url(@training_class), notice: '作业已删除.'


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homework
      @homework = Homework.find(params[:id])
    end




    # Never trust parameters from the scary internet, only allow the white list through.
    def homework_params
      params.require(:homework).permit(:title, :distribution_date, :submit_date,:teacher_id, :subject_type,
                                       :training_class_id,
                                       :student_ids
      )
    end
end
