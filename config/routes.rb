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

  post "rails/active_storage/direct_uploads", to: "direct_uploads#create"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :show] do
        collection do 
          get :attachments
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
          put :user_list
        end
      end
      resources :packages do
        member do
          post :buy_package

        end
        collection do
          post :redirect_request
        end
      end

    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
