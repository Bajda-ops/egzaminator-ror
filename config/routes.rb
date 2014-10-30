ActionController::Routing::Routes.draw do |map|
  #map.resources :users

  #map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.

  map.connect 'import_export/all_export.xml', :controller => 'import_export', :action => 'xml_export', :type => "0"
  map.connect 'import_export/test_group_export.xml', :controller => 'import_export', :action => 'xml_export', :type => "1"
  map.connect 'import_export/group_export.xml', :controller => 'import_export', :action => 'xml_export', :type => "2"
  map.connect 'import_export/test_export.xml', :controller => 'import_export', :action => 'xml_export', :type => "3"
  map.connect 'import_export/users_export.xml', :controller => 'import_export', :action => 'xml_export', :type => "4"

map.connect 'result/wyniki.pdf', :controller => 'result', :action => 'generate_pdf'
  map.connect 'media_rss/:id/feed.xml', :controller => 'test', :action => 'rss_playlist'
  map.connect 'file/show/:id/mov.flv', :controller => 'file', :action => 'show'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  #dla RESTa
  #map.signup '/signup', :controller => 'users', :action => 'new'
  #map.login '/login', :controller => 'sessions', :action => 'new'
  #map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  #map.list_users '/list_users', :controller => 'users', :action => 'list_users'
  #map.add_user '/add_user', :controller => 'users', :action => 'add_user'
end