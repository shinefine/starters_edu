class StudentsController < ApplicationController
  #学员 控制器
  before_action :set_student, only: [:show, :edit, :update, :destroy,
                                     :show_target,:save_target,
                                     :simulate_score_list]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
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
  end


  def simulate_score_list

  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)


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

    #@student.test_papers=TestPaper.where(id: params[:student][:test_paper_ids])

      if @student.update(student_params)
        redirect_to students_url, notice: '学员信息已保存'

      else
        render :edit
      end

  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: '学员已删除' }
      format.json { head :no_content }
    end
  end

  private
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
                                      :qq_number,
                                      :birth_day,
                                      :tinypost_number,

                                      :school_rank,
                                      :total_toefl_times,
                                      :total_sat_times,
                                      :expect_toefl_times,

                                      :identify_card,
                                      user_attributes: [:name,:email,:phone_number,:id],
                                      entry_and_target_scores_attributes:[:_destroy,:id,:student_id,:exam_type,:score_type,:final_score,:course_a_score,:course_b_score,:course_c_score,:course_d_score]
      )


    end
end
