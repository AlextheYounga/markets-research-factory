Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'main#home'
  get '/country-scraper' => 'main#country_scraper'
  get '/russell-scraper' => 'main#russell_scraper'
end
