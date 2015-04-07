ServerTools::Application.routes.draw do
  resources :arins, only: [:index, :create]
  resources :ips, only: [:index, :create] do
    collection { get :debian, :centos}
  end
  root :to => "ips#debian"
end
