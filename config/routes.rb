Rails.application.routes.draw do

  resources :expense_api do
    get 'get_all', on: :collection
    get 'get_expense', on: :member
    post 'new_expense', on: :collection
    put 'update_expense', on: :member
    delete "delete_expense", on: :member
  end

  resource :users, only: [:create] do
    post '/login', to: "users#login"
  end

end
