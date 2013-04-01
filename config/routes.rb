Eventoscte::Application.routes.draw do
	mount RailsAdmin::Engine => '/admincte'

	resources :events, path: "eventos"

	devise_for :admin_users
	root :to => "pages#index"
end
