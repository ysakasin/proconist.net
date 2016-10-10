Rails.application.routes.draw do
  root    'pages#index'

  get     '/about', to: 'pages#about'

  get     '/contest',       to: 'contests#index'
  get     '/contest/:nth',  to: 'contests#show',  as: :show_contest

  get     '/report',          to: 'reports#index'
  post    '/report',          to: 'reports#create'
  get     '/report/thankyou', to: 'reports#thankyou'

  get     '/entry',         to: 'articles#index'
  get     '/entry/archive', to: 'article_categories#index'
  get     '/entry/:url',  to: 'articles#show',  as: 'article'

  get     '/category/:name',  to: 'article_categories#show'

  get     '/auther/:name',  to: 'operators#show'

  get     '/sign_in',   to: 'sessions#new'
  post    '/sign_in',   to: 'sessions#create'
  delete  '/sign_out',  to: 'sessions#destroy'

  get     '/console', to: 'consoles#index'

  get     '/console/contest',           to: 'consoles/contests#index'
  get     '/console/contest/new',       to: 'consoles/contests#new', as: 'new_contest_console'
  post    '/console/contest',           to: 'consoles/contests#create'
  get     '/console/contest/:nth',      to: 'consoles/contests#show'
  get     '/console/contest/:nth/edit', to: 'consoles/contests#edit', as: 'edit_contest_console'
  patch   '/console/contest/:nth',      to: 'consoles/contests#update'

  get     '/console/entrant/',              to: 'consoles/products#index'
  get     '/console/entrant/contest/:nth',  to: 'consoles/products#list'
  get     '/console/entrant/new',           to: 'consoles/products#new',  as: 'new_product_console'
  get     '/console/entrant/:id',           to: 'consoles/products#show', as: 'show_product_console'
  post    '/console/entrant/',              to: 'consoles/products#create'
  post    '/console/entrant/:id',           to: 'consoles/products#update'
end
