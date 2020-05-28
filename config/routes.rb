Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'posts#index'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  resources :users
  resources :relationships, only: %i[create destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
