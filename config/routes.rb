Eventoscte::Application.routes.draw do

	mount RailsAdmin::Engine => '/admincte'

	resources :events, path: "eventos"

	get "inscreva-se" => redirect("/inscricoes/inscrever-se")

	resources :enrollments, path: "inscricoes", path_names:{new: "inscrever-se"}

	devise_for :admin_users
	root :to => "pages#index"
end
