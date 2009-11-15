ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'site'
  
  map.about 'about', :controller => 'site', :action => 'about'
  map.feedback 'feedback', :controller => 'site', :action => 'feedback'
  
  # routes for lists
  map.with_options :controller => 'month_lists' do |m|
    m.lists 'list/current', :action => 'index'
    m.generate_list 'list/generate', :action => 'generate'
    m.next_month 'list/nex-month', :action => 'next_month'
    m.previous_lists 'list/previous', :action => 'previous'
    m.past_list 'list/:year/:month', :action => 'past'
  end
  
  # routes for my-account
  map.with_options :controller => 'users' do |m|
    m.my_account 'my-account', :action => 'index'
    m.edit_my_account 'my-acount/edit', :action => 'edit'
  end
  
  # routes for statistics
  map.with_options :controller => 'statistics' do |m|
    m.statistics 'statistics', :action => 'index'
    m.statistics_detail 'statistics/show/:id/:title', :action => 'show', :title => nil
  end
  
  map.add_task_group 'task_groups/add_task_group', :controller => 'task_groups', :action => 'add_task_group'
  
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'  
  
  map.resources :lists, :member => {:complete_task => :post, :uncomplete_task => :get, :cancel_edit => :get}
  map.resources :task_groups
  map.resources :tasks
  map.resources :statistics
  map.resources :user_sessions
  map.resources :users, :collection => {:list => :get}, :member => {:tasks => :get}

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
