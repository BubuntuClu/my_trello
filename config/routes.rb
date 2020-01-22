Rails.application.routes.draw do
  root 'boards#index'

  resources :boards, only: %i(index show create), param: :title

  namespace :api do
    namespace :v1 do
      resource :columns, only: %i(destroy create)
    end
  end
end
