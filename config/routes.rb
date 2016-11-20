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

  get     '/category/:url',  to: 'article_categories#show', as: 'category'

  get     '/auther/:identifier',  to: 'operators#show', as: 'show_author'

  get     '/sign_in',   to: 'sessions#new'
  post    '/sign_in',   to: 'sessions#create'
  get     '/sign_out',  to: 'sessions#destroy'

  get     '/console', to: 'consoles#index'

  get     '/console/contest',           to: 'consoles/contests#index'
  get     '/console/contest/new',       to: 'consoles/contests#new', as: 'new_contest_console'
  post    '/console/contest',           to: 'consoles/contests#create'
  get     '/console/contest/:nth',      to: 'consoles/contests#show'
  get     '/console/contest/:nth/edit', to: 'consoles/contests#edit', as: 'edit_contest_console'
  patch   '/console/contest/:nth',      to: 'consoles/contests#update'

  get     '/console/entrant/',              to: 'consoles/products#index'
  get     '/console/entrant/contest/:nth',  to: 'consoles/products#list', as: 'list_product_in_contest_console'
  get     '/console/entrant/new',           to: 'consoles/products#new',  as: 'new_product_console'
  get     '/console/entrant/:id',           to: 'consoles/products#show', as: 'show_product_console'
  post    '/console/entrant/',              to: 'consoles/products#create'
  post    '/console/entrant/:id',           to: 'consoles/products#update'

  get     '/console/history',       to: 'consoles/histories#index'
  get     '/console/history/new',   to: 'consoles/histories#new'
  get     '/console/history/:id',   to: 'consoles/histories#show', as: 'show_history_console'
  post    '/console/history',       to: 'consoles/histories#create'
  delete  '/console/history/:id',   to: 'consoles/histories#destroy'
  patch   '/console/history/:id',   to: 'consoles/histories#update'

  get     '/console/report',      to: 'consoles/reports#index'
  get     '/console/report/:id',  to: 'consoles/reports#show', as: 'show_report_console'
  delete  '/console/report/:id',  to: 'consoles/reports#destroy'

  get     '/console/entry',       to: 'consoles/articles#index'
  post    '/console/entry',       to: 'consoles/articles#create'
  get     '/console/entry/:id',   to: 'consoles/articles#show', as: 'show_article_console'
  patch   '/console/entry/:id',   to: 'consoles/articles#update'
  get     '/console/draft/new',   to: 'consoles/articles#new'

  get     '/console/category',      to: 'consoles/article_categories#index'
  post    '/console/category',      to: 'consoles/article_categories#create'
  get     '/console/category/new',  to: 'consoles/article_categories#new'
  get     '/console/category/:id',  to: 'consoles/article_categories#show', as: 'show_category_console'
  patch   '/console/category/:id',  to: 'consoles/article_categories#update'

  get     '/console/user-settings', to: 'consoles/operators#show'
  patch   '/console/user-settings', to: 'consoles/operators#update'

end
