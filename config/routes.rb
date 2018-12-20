Rails.application.routes.draw do
  devise_for :users,
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