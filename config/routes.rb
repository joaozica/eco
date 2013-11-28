EcoEscreening::Application.routes.draw do
  
devise_for :users, :skip => [:registrations]                                          
    as :user do
      get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
      put 'users' => 'devise/registrations#update', :as => 'user_registration'            
    end
  devise_scope :user do
    post "sign_up", :to => "devise/registrations#create"
  end
  get "/qr"=>"drug_tests#qr"
  resources :clinics
  resources :companies
  resources :doctors
  resources :drug_tests
  resources :test_types
  resources :donors do
    collection { post :import }
  end
  resources :selections
  get "/import_data" => "donors#import_data"
  post "/import_data" => "donors#import"

  get "/donor/import" =>"donors#import_data"
  
  get "/users" => "users#index"
  get "/dashboard" =>"welcome#dashboard"
  post "/companies/set_avatar"
  get "/relatorio" =>"drug_tests#relatorio"
  post "/relatorio" =>"drug_tests#result_relatorio"


  get "/states/:id/cities" => "states#cities"

  get "/companies/:id/donors" => "companies#donors"

  get "/companies/:id/users" => "companies#users"

  post "/companies/new" => "companies#create"
  put "/companies/:id/edit" => "companies#update"
  
  get "/user_company"  => "companies#user_company"
  post "/companies/user_set_avatar"
  get "/user_company_index"  => "companies#user_company_index"

  post "/donors/new" => "donors#create"
  put "/donors/:id/edit" => "donors#update"

  post "/doctors/new" => "doctors#create"
  put "/doctors/:id/edit" => "doctors#update"

  post "/clinics/new" => "clinics#create"
  put "/clinics/:id/edit" => "clinics#update"
  get  "users/new" => "users#new"
  post "users/new" => "users#create"
  get  "users/:id/editar" => "users#edit"
  post "users/:id/editar" => "users#update"
  get  "users/:id/change_password" => "users#change_password"
  post "users/:id/change_password" => "users#change_password_save"
  delete "users/:id/destroy" =>"users#delete"
  get "users/:id" => "users#show"
  get "users/:id/index" =>"users#index_user"

  post "/selections/new" => "selections#create"
  put "/selections/:id/edit" => "selections#update"
  get "/selection_by_historical" =>"selections#selection_by_historical"
  get "/selection_random" => "selections#selection_random"
  post "/selection_by_historical" =>"selections#selection_by_historical_new"
  post "/selection_random" => "selections#selection_random_new"
  get "/selection_motivado" => "selections#selection_motivado"
  post "/selection_motivado" => "selections#selection_motivado_new"
  get "selections/success_selection"
  post "/drug_tests/new" => "drug_tests#create"
  put "/drug_tests/:id/edit" => "drug_tests#update"
  get "/testes_pendentes" =>"drug_tests#testes_pendentes"
  get "/testes_realizados" =>"drug_tests#testes_realizados"
  

  post "/test_types/new" => "test_types#create"
  put "/test_types/:id/edit" => "test_types#update"


  authenticated :user do  
    root :to => "welcome#dashboard"
  end

  def after_update_path_for(resource) 
    user_registration_path()
  end 

  # get 'users/sign_in'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :to => "welcome#index"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
