Eventoscte::Application.routes.draw do
	mount RailsAdmin::Engine => '/admincte'
	devise_for :admin_users
	
	get "inscreva-se" => redirect("/inscricoes/nova")

	resources :events, path: "eventos"
	resources :enrollments, path: "inscricoes", path_names:{new: "nova"}
	resources :releases, path: "imprensa"
	resources :projects, path: "agenda-produtiva"

	get "/:action" => "pages"
	root :to => "pages#index"
end
