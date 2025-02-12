Rails.application.routes.draw do
  resources :appointments, only: [:index, :new, :create]
  get 'appointments/available_slots', to: 'appointments#available_slots'
  root "appointments#new"
end