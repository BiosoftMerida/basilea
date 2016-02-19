Basilea::Application.routes.draw do

  resources :inscripcion_eventos

  resources :contactos

  resources :eventos

  resources :empresas

 # You can have the root of your site routed with "root"
  root to: 'static#index'


  devise_for :users, controllers: {
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  post 'aprobar_preinscritos', to: 'inscripcion_eventos#aprobar_preinscritos', as: :aprobar_preinscritos

  devise_scope :user do
    get 'users/new', to: 'users/registrations#new_user'
    post 'users/create_user',
         to: 'users/registrations#create_user'
    get 'user/show/:id', to: 'users/registrations#show', as: :user_show
    get 'users/index', to: 'users/registrations#index'
    get 'users/edit_user/:id', to: 'users/registrations#edit_user', as: :user_edit_user
    post 'users/update_user', to: 'users/registrations#update_user'
    delete 'users/delete_user/:id', to: 'users/registrations#delete_user', as: :user_delete_user
    get 'profile', to: 'users/profiles#profile'
    get 'profile/edit', to: 'users/profiles#edit'
    post 'profile/update', to: 'users/profiles#update'

    get 'ajustes', to: 'users/settings#index', as: :settings
    post 'save_subcuenca', to: 'users/settings#save_subcuenca'
  end

  scope module: 'users' do
    resources :client_users
  end

  resources :roles

  #TODO clean this
  #------------------JJ-don't touch this (8) MC HAMMER------------------------------
  resources :empresas_forestales
  resources :paises, except: :show

  resources :jquery_file_uploads, only: [:create, :destroy, :index] do
    member do
      delete 'wf_destroy_no_paginado'
    end
  end
 #-----------------------------------------------------------------------


  # Dynamic Selects y Controladores Dinamicos
  namespace :dynamic_select do
    get ':bo/subcuencas', to: 'dynamic_subcuencas#index', as: :dynamic_subcuencas
    get ':reserva_forestal_id/unidad_ordenacion', to: 'dynamic_unidad_ordenacion#index', as: :dynamic_unidad_ordenacion
    post 'num_parcela', to: 'dynamic_parcela#index', as: :dynamic_parcela
    post 'dynamic_fisiografia_paisaje', to: 'dynamic_fisiografia#paisaje'
    post 'dynamic_fisiografia_sub_paisaje', to: 'dynamic_fisiografia#sub_paisaje'

  end

  # Inventario Estatico
  namespace :masa_forestal do
    get 'mf_xcriterio', to: 'mf_xcriterio#index', as: :mf_xcriterio
    post 'load_table_mf_criterio', to: 'mf_xcriterio#wf_load_table_mf_xcriterio'
  end


  # Reportes del Censo Forestal
  namespace :censo_forestal do
    get 'mf_fisiografia',     to: 'mf_fisiografia#index', as: :mf_fisiografia
  end


end
