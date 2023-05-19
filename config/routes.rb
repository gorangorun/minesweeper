Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "boards#new"
  resources :boards, only: %i[index new show create] do
    member do
      namespace :boards, path: '', only: :update do
        resource :gameplay
      end
    end
  end

end
