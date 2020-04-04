Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get '/countries' => 'countries#countries'
  get '/stocks' => 'stocks#stocks'
end
