Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "competency_frameworks#index"


  resources :competency_frameworks,
    only: [:index, :show],
    constraints: { :id => /.*/ } do
      member do
        get :download
      end
    end
end
