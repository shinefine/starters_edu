class StudentsController < ApplicationController
  #学员 控制器
  before_action :set_student, only: [:show, :edit, :update, :destroy,:freezing,:unfreezing,
                                     :show_target,:save_target,
                                     :set_finished_test_papers]

  # GET /students
  # GET /students.json
  def index
    #学员列表有权限过滤数据需求,
    # 管理员能看到所有,
    # 普通员工只能看到他自己创建出的学员
    # 普通员工也能看到不是由他创建的,但属于他的培训班的学员(该员工是培训班的班主任)

    set_permission_students

  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.user =User.new

    @student.entry_and_target_scores.build({exam_type: 'TOEFL',score_type:'入口成绩'})
    @student.entry_and_target_scores.build(exam_type: 'TOEFL',score_type:'最终期望成绩')

    @student.entry_and_target_scores.build(exam_type: 'SAT',score_type:'入口成绩')
    @student.entry_and_target_scores.build(exam_type: 'SAT',score_type:'最终期望成绩')

    @cc=@student.entry_and_target_scores.count
  end

  # GET /students/1/edit
  def edit


    if(@student.entry_and_target_scores.count ==0)
      @student.entry_and_target_scores.build({exam_type: 'TOEFL',score_type:'入口成绩'})
      @student.entry_and_target_scores.build(exam_type: 'TOEFL',score_type:'最终期望成绩')

      @student.entry_and_target_scores.build(exam_type: 'SAT',score_type:'入口成绩')
      @student.entry_and_target_scores.build(exam_type: 'SAT',score_type:'最终期望成绩')
    end
  end


  def set_finished_test_papers

  end
  def simulate_score_list

  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    @student.creator = current_user.employee if current_user.employee?

   # @student.test_papers=TestPaper.where(id: params[:student][:test_paper_ids])  #设置学员做过的试卷信息

      if @student.save
        redirect_to students_url, notice: '学员已创建'
      else
        render :new
      end

  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update

    @student.test_papers=TestPaper.where(id: params[:student][:test_paper_ids])



      if @student.update(student_params)
        redirect_to students_url, notice: '学员信息已保存'

      else
        render :edit
      end

  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.update_attribute(:delete_flag,true)
    redirect_to students_url, notice: '学员已删除'

  end

  def freezing
    @student.update_attribute(:freezing_flag,true)
    redirect_to students_url, notice: '学员已冻结'
  end

  def unfreezing
    @student.update_attribute(:freezing_flag,false)
    redirect_to students_url, notice: '学员已恢复'
  end
  private


  def set_permission_students
    #根据登录用户的身份权限,筛选其能够操作的学员列表

    #Todo 此方法有重复,在training_class controller 内
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

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(
                                      :parent_name,
                                      :parent_tel,
                                      :parent2_name,
                                      :parent2_tel,
                                      :school,

                                      :birth_day,

                                      :school_rank,
                                      :total_toefl_times,
                                      :total_sat_times,
                                      :expect_toefl_times,


                                      :test_paper_ids,
                                      user_attributes: [:name,:email,:id,
                                                        :phone_number,
                                                        :qq_number,
                                                        :tinypost_number,
                                                        :identify_card,],
                                      entry_and_target_scores_attributes:[:_destroy,:id,:student_id,:exam_type,:score_type,:final_score,:course_a_score,:course_b_score,:course_c_score,:course_d_score]


      )


    end
end
