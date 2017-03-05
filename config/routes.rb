Rails.application.routes.draw do
  
  namespace :api, defaults: { format: 'json' } do
    api_version(module: 'v1', path: { value: 'v1' }) do
      resources :group_events, except: [:new, :edit]
    end
  end

end
