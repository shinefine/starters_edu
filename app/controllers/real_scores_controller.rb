class RealScoresController < ApplicationController
  def index_with_all_examinations

    #学员特定,列出学员的所有真实成绩
    @student =Student.find(params[:student_id])

    @exam_type =params[:exam_type]

    if @exam_type=="SAT"
      @scores=@student.real_scores.sat.true_real
    elsif @exam_type=="TOEFL"
      @scores=@student.real_scores.toefl.true_real
    end


  end
end