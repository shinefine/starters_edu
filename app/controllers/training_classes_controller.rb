class TrainingClassesController < ApplicationController
  #培训班 控制器
  before_action :set_training_class, only: [:show, :edit, :update, :destroy,:set_teachers_students]

  # GET /training_classes
  # GET /training_classes.json
  def index


    if(current_user.student?)
      @student =current_user.student
      @training_classes=@student.training_classes
    end

    if (current_user.teacher?)
      @teacher =current_user.teacher
      @training_classes=@teacher.training_classes.distinct
    end

    if (current_user.employee?)
      if current_user.can_set_training_class_info?  #管理员/校长
        @training_classes = TrainingClass.all
      else
        @training_classes =TrainingClass.where(master_teacher_id: current_user.employee.id )
      end
    end
  end

  # GET /training_classes/1
  # GET /training_classes/1.json
  def show

  end

  # GET /training_classes/new
  def new
    @training_class = TrainingClass.new
    @training_class.start_date = Time.now
    @training_class.end_date =1.months.from_now
    @training_class.exam_type= params[:exam_type]

    set_training_class_types
    set_subject_types
    set_permission_students
  end


  # GET /training_classes/1/edit
  def edit
    set_training_class_types
    set_subject_types
    set_permission_students
  end

  # POST /training_classes
  # POST /training_classes.json
  def create
    @training_class = TrainingClass.new(training_class_params)

    if @training_class.save
      redirect_to training_classes_url, notice: "培训班#{@training_class.name}已创建"

    else
      set_subject_types
      set_training_class_types
      render :new

    end

  end


  # PATCH/PUT /training_classes/1
  # PATCH/PUT /training_classes/1.json
  def update
    #render inline: params.inspect


      if @training_class.update(training_class_params)
        redirect_to training_classes_url, notice: "培训班#{@training_class.name}信息已保存"

      else
        set_subject_types
        set_training_class_types
        render :edit

      end

  end

  # DELETE /training_classes/1
  # DELETE /training_classes/1.json
  def destroy
    @training_class.destroy
    respond_to do |format|
      format.html { redirect_to training_classes_url, notice: "培训班#{@training_class.name}已删除" }
      format.json { head :no_content }
    end
  end

  private

  def set_training_class_types
    if( @training_class.exam_type=='SAT')
      @training_class_types =TrainingClassType.sat_types
    elsif(@training_class.exam_type=='TOEFL')
      @training_class_types =TrainingClassType.toefl_types
    end
  end

  def set_subject_types

    if(@training_class.exam_type == 'SAT')
      @subject_types =[['SAT_CR', 'CR'] ,['SAT_Math', 'Math'],['SAT_Writing', 'Writting']]
    elsif (@training_class.exam_type == 'TOEFL')
      @subject_types =[['TOEFL_Listen', '听力'] ,['TOEFL_Talk', '口语'],['TOEFL_Read', '阅读'],['TOEFL_Write', '写作']]
    else
      @subject_types =[['错误','错误'],['exam_type_未指定','exam_type_未指定']]
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_training_class
      @training_class = TrainingClass.find(params[:id])
    end

  def set_permission_students
    #根据登录用户的身份权限,筛选其能够操作的学员列表

    #Todo 此方法有重复,在 student controller 内
    if current_user.admin?
      @students = Student.all
    elsif current_user.employee?

      @students = Student.where(creator: current_user.employee)
      students_2= current_user.employee.training_classes.reduce{|tc1,tc2| tc1.students | tc2.students }
      @students = @students | students_2
    else
      @students=[]
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_class_params
      params.require(:training_class).permit(:name, :code, :start_date, :end_date,
                                             :exam_type,:training_class_type,
                                             :text_book_id,
                                             :master_teacher_id,
                                             :sat_writing_teacher_id,
                                             :sat_math_teacher_id,
                                             :sat_cr_teacher_id,
                                             :toefl_listen_teacher_id,
                                             :toefl_talk_teacher_id,
                                             :toefl_read_teacher_id,
                                             :toefl_write_teacher_id,
                                             student_ids:[],
                                             text_book_ids:[],
                                             subjects_attributes: [:_destroy,:id,:name,:teacher_id]
      )
    end
end
