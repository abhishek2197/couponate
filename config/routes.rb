Rails.application.routes.draw do
  resources :comments

  devise_for :users
  resources :links do
    member do
      put "like", to: "links#upvote"
      put "dislike", to: "links#downvote"
    end
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      resources :links
      # resources :application
    end
  end
  namespace 'api' do
    namespace 'v1' do
      resources :users
      # resources :application
    end
  end
  root to: "links#index"
end
