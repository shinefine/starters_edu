class HomePageController < ApplicationController
  def index
    
    render layout: false
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
end
