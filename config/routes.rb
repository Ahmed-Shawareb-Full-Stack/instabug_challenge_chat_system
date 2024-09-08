Rails.application.routes.draw do
  resources :apps, param: :token, only: [ :index, :create, :show, :update ] do
    resources :chats, param: :number, only: [ :index, :create, :show ] do
      resources :messages, param: :number, only: [ :index, :create, :show, :update ] do
        collection do
          post "search"
        end
      end
    end
  end
end
