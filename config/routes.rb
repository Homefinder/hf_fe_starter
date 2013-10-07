Bdhf::Application.routes.draw do
  get "homes" => "homes#index"
  get "homes/search"

  root :to => "content#homepage"
end
