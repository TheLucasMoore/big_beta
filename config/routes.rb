Rails.application.routes.draw do
  devise_for :users,
              path: '',
              path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
              },
              controllers: {
                sessions: 'sessions',
                registrations: 'registrations'
              }

  get 'bouldering' => 'grades#bouldering'
  get 'sport' => 'grades#sport'
  resources :climbs
  resources :grades
  resources :routes
  root 'application#send_it'
end