Rails.application.routes.draw do

 resources :surveys
  post 'scores/new', to:'scores#new_post', as:'new_score_post'
  get 'scores/new', to:'scores#index', as:'new_score_get'
  resources :scores

  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :surveys

  match 'surveys/new', :to => 'surveys#create', 
                       :via => :post, 
                       :as => :post_surveys
					   
    post '/pdf', to:'surveys#generate_pdf', as: 'generate_pdf' 
	get '/pdf', to:'lectures#index', as:'generate_pdf_get'

  get '/lectures/surveys/:id', to:'surveys#index_specific', as:'specific_surveys'
  
  post '/lectures/surveys/:id', to:'surveys#index_specific_post'





  get '/lectures', to:'lectures#index', as:'all_lectures'
  patch '/lectures/:id', to:'lectures#update'
  put '/lectures/:id', to:'lectures#update'
  delete '/lectures/:id', to:'lectures#destroy', as:'delete_lecture'
  resource :lectures
  get '/lectures/:id', to:'lectures#show', as:'lecture'
  get '/lectures/edit/:id', to:'lectures#edit', as:'edit_lecture'

  get '/statistics', to:'lectures#statistics', as:'statistics'
  get '/statistics/:id', to:'surveys#statistics_surveys', as:'statistics_surveys'
  post '/statistics/:id', to:'surveys#statistics_surveys_post'
  get '/statistics/:lecture_id_p/0', to:'surveys#statistics_surveys_all', as:'statistics_surveys_all'
  post '/statistics/:lecture_id_p/0', to:'surveys#statistics_specific_post'
  get '/statistics/:lecture_id_p/:survey_id_p', to:'surveys#statistics_specific', as:'statistics_specific'
  post '/statistics/:lecture_id_p/:survey_id_p', to:'surveys#statistics_specific_post'
  
    



   root 'welcome#index'

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
