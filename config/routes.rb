Rails.application.routes.draw do

  get 'home_page/upload'
  get 'home_page/training_class_schedule'
  post 'home_page/upload'



  resources :subjects

  resources :text_books
  resources :employees do
    patch :unfreezing, on: :member
    patch :freezing, on: :member
  end
  resources :users do
    get :set_password , on: :member
  end

  resources :questions


  resources :students do

    resources :real_scores
    #二留一
    get :set_real_scores ,on: :member
    get :set_entry_and_target_scores ,on: :member


    patch :unfreezing, on: :member
    patch :freezing, on: :member

    get :set_finished_test_papers ,on: :member


    resources :examinations  do #学员包含多个模拟考试
      resources :scores ,only: [:new,:create,:edit,:update]

    end

  end

  resources :examinations  do #培训班包含多个模拟考试
    resources :scores  do
      get :index_for_all_students , on: :collection  #列出某次特定模考 的所有学员考试成绩

    end
  end



  # 无用 get 'students/:id/simulate_score_list'=>'students#simulate_score_list',as: 'student_simulate_score_list'

  post 'session/create'

  get 'session/destroy' ,as:'log_out'

  resources :test_papers do    #考试套题包含套题的section
    resources :sections
  end

  resources :comments,only:[:destroy]



  resources :training_classes do

    resources :attendances #考勤


    resources :dictations #听写
    resources :examinations #模拟考
    resources :homeworks #作业

    resources :students do #培训班包含多个学员

      resources :scores do
        get :index_with_all_examinations ,on: :collection #列出某个培训班下 某个学员的 所有模考成绩
      end

      resources :comments ,only: [:index,:create]  #讲师可以给学员创建评语
    end


  end
  resources :teachers do
    patch :unfreezing, on: :member
    patch :freezing, on: :member
  end

  root 'home_page#index'


  get 'home_page/index'
  get 'home_page/reports'
  get 'home_page/big_data_report_scores'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end