Rails.application.routes.draw do
  root 'workouts#index'
  get 'home/top' => "home#top"
  
  get "workouts/:id/more" => "workouts#more"
  post "users/create" => "users#create"
  
  get "users/index" => "users#index"
  post "likes/:workout_id/create" => "likes#create"
  post "likes/:workout_id/destroy" => "likes#destroy"
  
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  
  resources :users 

  resources :workouts do
    get :search, on: :collection
    get :day, on: :collection
    resources :records 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
