Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => 'pages#index'

  resources :devise
  
  resources :events
  get '/events/:id/register', to: 'event_confirmations#new'
  post '/events/:id/register', to: 'event_confirmations#create'
  
  resources :fairs
  get '/fairs/:id/register', to: 'fair_confirmations#new'
  post '/fairs/:id/register', to: 'fair_confirmations#create'
  
  resources :news_items
  resources :testimonials
  resources :team_members
  
  resources :schools do
    get 'higher-education', :on => :collection
    get 'secondary-education', :on => :collection
  end
  resources :countries do
    resources :schools, only: [:index] do
      get 'higher-education', :on => :collection
      get 'secondary-education', :on => :collection
    end
  end
  
  get '/about' => 'pages#about'
  get '/about_ge' => 'pages#about_ge'
  get '/contact' => 'pages#contact'
  get '/contact_ge' => 'pages#contact_ge'
  get '/event-registrations' => 'pages#event_registrations'
  get '/fair-registrations' => 'pages#fair_registrations'
  get '/styles' => 'pages#temporary'
  get '/users/sign_up' => 'devise/registrations#new'
end
