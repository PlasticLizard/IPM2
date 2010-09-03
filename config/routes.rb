Ipm::Application.routes.draw do 

  devise_for :users

  namespace :admin do

    resources :departments do
      collection do
        get :manage
      end

      resources :roles do
        collection { get :select }
      end

      resources :requirement_sets do
        collection { get :list }
      end
      resources :credentials do
        collection do
          get :list, :quick_add
        end
      end
    end

    resources :regions, :stations, :transport_units
    
    resources :organizational_units do
      collection { get :select }
    end

    resources :requirement_sets do
      resources :requirement_groups do
        member do
          put :add_requirement
          delete :remove_requirement
        end
      end
    end
    
    resources :companies do
      member { post :organizational_unit }
      resources :regions, :stations, :transport_units
    end

    resources :credentials do
      collection { get :select }
    end

    resources :employees do
      resources :issued_credentials do
        collection do
          put :issue
          get :select
          delete :revoke
        end
      end
    end
  end

  resources :staff_requirements

  match '/:controller(/:action(/:id))'
#
#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
