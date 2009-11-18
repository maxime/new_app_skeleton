ActionController::Routing::Routes.draw do |map|
  map.resources :user_sessions
  map.resources :users
  map.resources :password_resets

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.signup '/sign-up', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'activations', :action => 'create'
  map.lost_password '/lost_password', :controller => 'password_resets', :action => 'new'

  map.home '/', :controller => 'home', :action => 'index'
end
