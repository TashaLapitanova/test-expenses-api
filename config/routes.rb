Rails.application.routes.draw do

  resources :expense_api do
    get 'get_all', on: :collection
    get 'get_expense', on: :member
    post 'new_expense', on: :collection
    put 'update_expense', on: :member
    delete "delete_expense", on: :member
  end

  resources :income_api do
    get 'get_all', on: :collection
    get 'get_income', on: :member
    post 'new_income', on: :collection
    put 'update_income', on: :member
    delete "delete_income", on: :member
  end

  resource :users, only: [:create] do
    post '/login', to: "users#login"
  end

  resources :stats do
    get 'get_total_balance', on: :collection
    get 'get_balance_within_period', on: :collection
    get 'get_users_with_stats_within_period', on: :collection
  end

end
