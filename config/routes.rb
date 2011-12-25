Listode::Application.routes.draw do
  root :to => 'site#index'

  # generic site routes
  match 'about' => 'site#about', :as => 'about'
  match 'feedback' => 'site#feedback', :as => 'feedback'

  match 'list/current'      => 'month_lists#index',       :as => 'lists'
  match 'list/generate'     => 'month_lists#generate',    :as => 'generate_list'
  match 'list/nex-month'    => 'month_lists#next_month',  :as => 'next_month'
  match 'list/previous'     => 'month_lists#previous',    :as => 'previous_lists'
  match 'list/:year/:month' => 'month_lists#past',        :as => 'past_list'

  match 'my-account'      => 'users#index', :as => 'my_account'
  match 'my-account/edit' => 'users#edit',  :as => 'edit_my_account'

  match 'statistics'                    => 'statistics#index',  :as => 'statistics'
  match 'statistics/show/:id(/:title)'  => 'statistics#show',   :as => 'statistics_detail'

  match 'task_groups/add_task_group' => 'task_groups#add_task_group', :as => 'add_task_group'

  match 'login'   => 'user_sessions#new',     :as => 'login'
  match 'logout'  => 'user_sessions#destroy', :as => 'logout'

  resources :lists do
    member do
      post 'complete_task'
      get 'uncomplete_task'
      get 'cancel_edit'
    end
  end
  resources :task_groups
  resources :tasks
  resources :statistics
  resources :user_sessions
  resources :users do
    get 'list', :on => :collection
    get 'tasks', :on => :member
  end
end
