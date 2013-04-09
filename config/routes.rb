Eventoscte::Application.routes.draw do
  get "interviews/show"

	mount RailsAdmin::Engine => '/admincte'
	devise_for :admin_users
	get "inscreva-se" => redirect("/inscricoes/nova")
	get "/evento/:slug" => "events#show"

	resources :events, 		path: "eventos"
	resources :enrollments, path: "inscricoes", path_names:{new: "nova"}
	resources :releases, 	path: "imprensa"
	resources :projects, 	path: "agenda-produtiva"
	resources :interviews, 	path: "entrevistas"
	
	get "/:action" => "pages"
	root :to => "pages#index"
end
