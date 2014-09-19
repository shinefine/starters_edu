module TrainingClassesHelper

  def helper_get_student_comments(student)
    comments = student.comments.filter_by_training_class(@training_class)
    comments =@comments.filter_by_teacher(@teacher) if current_user.teacher? #讲师只能看到他自己写的对某学员的评语. 而其它人(员工,学员)则能看到所有讲师写的评语

    return comments
  end
end
