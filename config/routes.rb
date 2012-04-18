PlayApp::Application.routes.draw do
  match '/signup',  to: 'users#new'
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  root to: 'static_pages#home'
  resources :users
end
