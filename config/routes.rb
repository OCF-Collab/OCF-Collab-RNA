Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "search#index"

  get "containers/:container_id/search" => "search#index",
      as: :container_search,
      constraints: { :container_id => /.+/ }

  resources :competencies, only: :show, constraints: { id: /.*/ }

  resources :containers,
    only: [:index, :show],
    format: false,
    defaults: { format: "html" },
    constraints: { :id => /.*/ } do
      member do
        get :download
      end
    end
end
