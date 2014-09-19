class CommentsController < ApplicationController
#评语控制器
  before_action :set_training_class_and_teacher

  def index
    @comments = @student.comments.filter_by_training_class(@training_class)
    @comments =@comments.filter_by_teacher(@teacher) if current_user.teacher? #讲师只能看到他自己写的对某学员的评语. 而其它人(员工,学员)则能看到所有讲师写的评语
    @comment_new = @student.comments.build()
  end


  def create
    @comment_new = @student.comments.create(comment_params)
    @comments =@student.comments
    @comment_new.teacher = @teacher
    @comment_new.training_class =@training_class
    @comment_new.comment_date=Time.now
    if(@comment_new.save)
      redirect_to  training_class_student_comments_url(@training_class,@student)
    else
      render :index
    end
  end


  private
  def set_training_class_and_teacher
    @training_class = TrainingClass.find(params[:training_class_id])

    @student = Student.find(params[:student_id])

    @teacher = current_user.teacher if current_user.teacher?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text)
  end

end