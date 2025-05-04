Rails.application.routes.draw do
  get "/", to: ->(_) { [200, {}, ["OK"]] }

  get '/protected', to: 'protected#demo'

  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    resources :projects, only: [:index, :create, :show, :update, :destroy]
end
