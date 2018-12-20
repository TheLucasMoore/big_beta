Rails.application.routes.draw do
  get 'bouldering' => 'grades#bouldering'
  get 'sport' => 'grades#sport'
  resources :climbs
  resources :grades
  resources :routes
  root 'application#hello'
end
