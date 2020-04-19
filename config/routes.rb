Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
  get '/countries' => 'countries#countries'
  get '/stocks' => 'stocks#stocks'
  get '/research/chart_generator' => 'research#chart_generator'
end
