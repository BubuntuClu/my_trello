Rails.application.routes.draw do
  root 'boards#index'

  resources :boards, only: %i(index show create), param: :title
end
