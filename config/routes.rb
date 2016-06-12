Rails.application.routes.draw do
  root    'pages#index'

  get     '/about', to: 'pages#about'

  get     '/contest',       to: 'contests#index'
  get     '/contest/:nth',  to: 'contests#show'

  get     '/report',          to: 'reports#index'
  post    '/report',          to: 'reports#create'
  get     '/report/thankyou', to: 'reports#thankyou'

  get     '/entry',         to: 'articles#index'
  get     '/entry/archive', to: 'article_categories#index'
  get     '/entry/:title',  to: 'articles#show'

  get     '/category/:name',  to: 'article_categories#show'

  get     '/auther/:name',  to: 'operators#show'

  get     '/sign_in',   to: 'sessions#new'
  post    '/sign_in',   to: 'sessions#create'
  delete  '/sign_out',  to: 'sessions#destroy'

  get     '/console', to: 'consoles#index'
end
