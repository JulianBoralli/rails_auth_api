Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'


  # User Routes
  scope path: 'v1', :format => true, :constraints => { :format => 'json' } do
    post "/signup" => "users#create"
  end
end
