Melbourneunibasketball::Application.routes.draw do
  namespace :admin do
    resources :pages
    resources :news_items
    resources :members do
      member do
        get 'acknowledge_payment'
      end
      
      collection do
        get 'pending'
        get 'csv_export'
      end
    end
  end

  match 'admin' => 'admin/news_items#index'

  resources :members, only: [:index, :new, :create] do
    member do
      get 'mubc_account_details'
      post 'confirm_paypal_purchase'
      get 'thankyou'
    end
    
    collection do
      get 'review_paypal_payment'
    end
  end

  post '/tinymce_assets' => 'admin/tinymce_assets#create'

  match 'members' => 'members#index'
  match 'membership' => 'members#new'
  match 'members/join_the_club' => 'members#new', :as => :join_the_club
  match 'members/documents_and_forms' => 'members#documents_and_forms', :as => :documents_and_forms
  match 'members/uniforms' => 'members#uniforms', :as => :uniforms

  match 'news' => 'news#archived', :as => :archived_news
  match 'news/:archived_year' => 'news#archived', :as => :archived_news_for_year
  match 'news/:year/:article' => 'news#news_item', :as => :article
  match 'authors/:author' => 'news#author', :as => :author
  
  match 'dribbling_balls_newsletter' => 'news#dribbling_balls', as: :dribbling_balls

  match 'event_calendar' => 'news#event_calendar', :as => :event_calendar

  match 'about' => 'about#index', :as => :about
  match 'about/bigv' => 'about#big_v', :as => :big_v
  match 'about/sponsors' => 'about#sponsors', :as => :sponsors
  match 'about/constitution' => 'about#constitution', :as => :constitution
  match 'about/competition_titles' => 'about#competition_titles', :as => :competition_titles
  match 'about/representative_mvps' => 'about#representative_mvps', :as => :representative_mvps
  match 'about/team_mvps' => 'about#team_mvps', :as => :team_mvps
  match 'about/most_improved_players' => 'about#most_improved_players', :as => :most_improved_players
  match 'about/best_first_year_players' => 'about#best_first_year_players', :as => :best_first_year_players
  match 'about/coaches_awards' => 'about#coaches_awards', :as => :coaches_awards
  match 'about/bigv_league_awards' => 'about#bigv_league_awards', :as => :bigv_league_awards
  match 'about/bigv_seasons' => 'about#bigv_seasons', :as => :bigv_seasons
  match 'about/unigames_teams' => 'about#unigames_teams', :as => :unigames_teams
  match 'about/blues_awards' => 'about#blues_awards', :as => :blues_awards
  match 'about/green_and_gold_winners' => 'about#green_and_gold_winners', :as => :green_and_gold_winners
  match 'about/committee' => 'about#committee', :as => :committee
  match 'about/social_awards' => 'about#social_awards', :as => :social_awards
  match 'about/distinguished_service_awards' => 'about#distinguished_service_awards', :as => :distinguished_service_awards
  match 'about/life_members' => 'about#life_members', :as => :life_members
  
  root :to => 'news#index'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
