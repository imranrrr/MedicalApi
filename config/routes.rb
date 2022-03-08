Rails.application.routes.draw do
  
  get '/current_user', to: 'current_user#index'
  get 'private/test'
  
  scope 'api/v1' do
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'api/v1/sessions',
      registrations: 'api/v1/registrations'
    }
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :show] do
        collection do 
          put :upload_file
        end
      end
      resources :directories do 
        member do 
           put :delete_temporary
           put :move_from_trash
           post :shared_directory
           post :upload_file
        end
        collection do 
          get :delete_temporary_directories
          get :user_list
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
