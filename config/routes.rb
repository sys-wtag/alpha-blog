Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#home'
  get 'about', to:'welcome#about'
  get 'signup', to:'users#new'
  resources :users, except: [:new]
   resources :articles do
     resources :comments
   end
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'
   resources :categories
 end
