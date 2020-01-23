Rails.application.routes.draw do
  root 'boards#index'

  resources :boards, only: %i(index show create), param: :title

  namespace :api do
    namespace :v1 do
      resources :columns, only: %i(create destroy) do
        resources :tasks, only: %i(create update destroy), shallow: true
      end
    end
  end
end
