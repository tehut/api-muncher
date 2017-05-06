Rails.application.routes.draw do
 root to:'search#welcome', to:'search#welcome'

  get 'search', to: 'search#index', as:'search'

  get 'searches/:item/', to: 'search#show', as: 'searches'

  # post 'search/:query/send_search', to:'search#send_search', as:'send_search'

end
