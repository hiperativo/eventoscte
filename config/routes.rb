Eventoscte::Application.routes.draw do
	mount RailsAdmin::Engine => '/admincte'
	get "inscreva-se" => redirect("/inscricoes/inscrever-se")
	resources :events, path: "eventos"
	resources :enrollments, path: "inscricoes", path_names:{new: "inscrever-se"}
	resources :releases, path: "imprensa"
	resources :agenda_projects, path: "agenda-produtiva"
	devise_for :admin_users
	get "/:action" => "pages"
	root :to => "pages#index"
end
