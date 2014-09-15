class StudentsController < ApplicationController
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
    respond_to do |format|
      if @student.save
        format.html { redirect_to students_url, notice: '学员已创建' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update

    #@student.test_papers=TestPaper.where(id: params[:student][:test_paper_ids])

    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_url, notice: '学员信息已保存' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
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
      params.require(:student).permit(:entry_score_sat,
                                      :target_score_sat, :entry_score_toefl, :target_score_toefl,
                                      :parent_name,
                                      :parent_tel,
                                      :school,
                                      :qq_number,
                                      :tinypost_number,
                                      :entry_sat_cr,
                                      :entry_sat_math,
                                      :entry_sat_writing,
                                      :target_sat_cr,
                                      :target_sat_math,
                                      :target_sat_writing,
                                      :entry_toefl_reading,
                                      :entry_toefl_listen,
                                      :entry_toefl_say,
                                      :entry_toefl_writing,
                                      :target_toefl_reading,
                                      :target_toefl_listen,
                                      :target_toefl_say,
                                      :target_toefl_writing,
                                      :school_rank,
                                      :total_toefl_times,
                                      :total_sat_times,
                                      :expect_toefl_times,
                                      :expect_sat_exam_month_5,
                                      :expect_sat_exam_month_6,
                                      :expect_sat_exam_month_10,
                                      :expect_sat_exam_month_11,
                                      :expect_sat_exam_month_12,
                                      :identify_card,
                                      user_attributes: [:name,:email,:phone_number]
      )


    end
end
