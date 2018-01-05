Rails.application.routes.draw do
  devise_for :users

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages

  root to: "home#welcome"
end
