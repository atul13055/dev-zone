Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'home#index'

  get 'member/:id', to: 'members#show', as: 'member'
  get 'edit_description', to: 'members#edit_description', as: 'edit_member_description'
  patch 'update_description', to: 'members#update_description', as: 'update_member_description'

  get 'edit_skill', to: 'members#edit_skill', as: 'edit_member_skill'
  patch 'update_skill', to: 'members#update_skill', as: 'update_member_skill'

  get 'edit_personal_details', to: 'members#edit_personal_details', as: 'edit_member_personal_details'
  patch 'update_personal_details', to: 'members#update_personal_details', as: 'update_member_personal_details'
  get 'member-connections/:id', to: "members#connections", as: "member_connections"

  resources :work_experiences
  resources :connections


  #match '*unmatched', to: 'application#not_found_method', via: :all
end
