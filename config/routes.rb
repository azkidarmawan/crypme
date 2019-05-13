Rails.application.routes.draw do
  get 'home/homepage'
  root 'home#homepage'
  get "/encrypt" => "home#encrypt"
  get "/decrypt" => "home#decrypt"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
