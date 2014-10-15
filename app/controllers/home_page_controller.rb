class HomePageController < ApplicationController
  def index
    
    render layout: false
  end

  def big_data_report_scores
    #大数据统计分析功能
    @year =params[:year]
    var_year =@year.to_i
    @scores_grp_by_student = RealScore.sat.true_real.where(year:var_year).group_by{|record| record.student_id}

    @students=[]
    @scores_grp_by_student.each{|key_id,value_realscores|
      student = Student.find(key_id)
      student.cache_real_scores = value_realscores
      student.calculate_sat_scores_trend
      @students<<student
    }


  end

  def training_class_schedule
    #列出所有培训班的课程表
    dir =Dir.open(Rails.root.join('public', 'uploads'))
    @files =dir.reject { |d| d == '.' || d == '..'}

  end


  def upload
    uploaded_io = params[:schedule]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    redirect_to  home_page_training_class_schedule_url


  end
  def delete_schedule
    File.delete(Rails.root.join('public', 'uploads', params[:filename]))


    redirect_to  home_page_training_class_schedule_url
  end
end
