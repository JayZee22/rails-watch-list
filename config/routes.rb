Rails.application.routes.draw do
  get 'movies/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # create list
  get 'lists/new', to: 'lists#new'
  post 'lists', to: 'lists#create'
  # A user can see all the lists
  get 'lists', to: 'lists#index'
  # A user can see the details of a given list and its name
  get 'lists/:id', to: 'lists#show', as: :list
  # A user can add a new bookmark (movie/list pair) to an existing list
  # A user can see all the bookmarks of a list
  # A user can delete a bookmark from a list
  resources :lists do
    resources :bookmarks, only: [:create]
  end

  resources :bookmarks, only: [:destroy]

  resources :movies, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  end
end
