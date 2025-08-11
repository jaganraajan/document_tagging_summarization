Rails.application.routes.draw do
  root "documents#index"
  resources :documents, only: [:index, :show, :new, :create] do
    member do
      post :summarize
      post :tag
    end
  end
end