class ScoresController < ApplicationController
  before_action :set_simulate_test_score, only: [:show, :edit, :update, :destroy]
  before_action :find_student,except: [:index_for_all_students]
  before_action :find_simulate_test, except:[:index,:index_with_all_examinations]


  # GET /scores
  # GET /scores.json
  def index
    #所有学员所有模考成绩
    @student= Student.find(params[:student_id])
    @training_class =TrainingClass.find(params[:training_class_id])
    @examinations =@training_class.examinations

    @scores = @student.scores
  end


  #GET  /training_classes/:training_class_id/examinations/:examination_id/scores/index_for_all_students(.:format)
  def index_for_all_students

    #模考特定,列出本次模考的所有学员的成绩


    @examination =Examination.find(params[:examination_id])

    @training_class =@examination.training_class

    @training_class_students =@training_class.students

    @scores=@examination.scores
  end

  def index_with_all_examinations

    #学员特定,列出学员的所有模考成绩
    @student =Student.find(params[:student_id])

    @training_class =TrainingClass.find(params[:training_class_id])
    @examinations =@training_class.examinations
    @scores=@student.scores


  end


  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
    @score.examination =@examination
    @score.student =@student
    @test_paper.sections.each do |section|
       section.questions.each do |question|
         @score.score_details.build({question: question})
       end
    end

  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create


    @score = Score.new(simulate_test_score_params)

    if @score.save

      redirect_to index_for_all_students_examination_scores_path(@examination),
                notice: '模考成绩已保存'

    end

  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(simulate_test_score_params)


        format.html {  redirect_to index_for_all_students_examination_scores_path(@examination),notice: '学员成绩己记录.'  }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to examination_scores_url, notice: 'Simulate test score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    def find_simulate_test
      @examination= Examination.find(params[:examination_id])
      @training_class =@examination.training_class
      @test_paper =@examination.test_paper

    end
    def find_student
      @student =Student.find(params[:student_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_simulate_test_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def simulate_test_score_params
      params.require(:score).permit(:examination_id, :student_id,:final_score,

                                    :cr_score,:math_score, :writing_score, :essay_writing_score,

                                    :course_a_score,:course_b_score,:course_c_score,:course_d_score,

                                    :stat_01,:stat_02,:stat_03,:stat_04,:stat_05,:stat_06,:stat_07,:stat_08,:stat_09,
                                    :stat_10,:stat_11,:stat_12,:stat_13,
                                    :hard_level1,:hard_level2,:hard_level3,:hard_level4,:hard_level5,

                                    score_details_attributes: [:id,:answer_result,:score_number,:section_question_id])
    end
end
