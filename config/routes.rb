Rails.application.routes.draw do
    resources :recipes do
		resources :ingredients, only: :create
	end
  devise_for :users
  root "hello#index"
end
