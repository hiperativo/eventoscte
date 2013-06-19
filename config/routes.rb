Eventoscte::Application.routes.draw do

	mount RailsAdmin::Engine => '/admincte'
	devise_for :admin_users
	get "inscreva-se" => redirect("/inscricoes/nova")
	get "/evento/:slug" => "events#show"
	get "/patrocinadores" => "pages#sponsors"
	get "/palestrante/:speaker_id" => "speakers#show", speaker_id: /\d*/
	get "/palestrante/:speaker_name" => "speakers#show"

	resources :events, path: "eventos" do
		resources :speakers, path: "palestrantes"
		resources :photos, path: "fotos" do
			post "sort", on: :collection
		end

		resources :videos, path: "videos"
	end
	
	resources :enrollments, path: "inscricoes", path_names:{new: "nova"}
	resources :releases, 	path: "imprensa"
	resources :projects, 	path: "agenda-produtiva"
	resources :interviews, 	path: "entrevistas"

	get "/:action" => "pages"
	root :to => "pages#index"
end
