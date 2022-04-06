Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get "bienvenida", to: "home#index"
  
  get "perfil", to: "users#edit" #para actualizar el usuario con imagen
  resources :users, only:[:update]#para actualizar el usuario con imagen

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index" #debemos definir nuestro rootpath

#  get "articles/user/:user_id", to: "articles#from_author" #cambiado a dentro de articles
  resources :articles do
  get "user/:user_id", to: "articles#from_author", on: :collection #on: :collection hace que la ruta se va a generar para una coleccion como articles/user/:user_id
  #este seria lo alternativo a on: collection es on: :member
  #get "articles/:id/user/:user_id", to: "articles#from_author", on: :member #on member para un articulo en especifico

  end

#  get "articles", to: "articles#index"
#  get "articles/new", to: "articles#new", as: :new_articles
#  get "articles/:id", to: "articles#show"
#  get "articles/:id/edit", to: "articles#edit"
#  patch "articles/:id", to: "articles#update", as: :article
#  post "articles", to:"articles#create"
#  delete "articles/:id", to:"articles#destroy"

end
