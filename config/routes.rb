Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: 'posts#index'
  resources :posts
  resources :users

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
