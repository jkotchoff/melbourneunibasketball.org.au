# Melbourneunibasketball::Application.routes.draw do
Rails.application.routes.draw do
  # http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :pages

    resources :newsletters, only: [:index, :new, :create, :destroy]

    resources :news_items do
      collection do
        post 'upload_image'
      end
    end
    resources :members do
      member do
        post 'refund'
      end

      collection do
        get 'csv_export'
        get 'uniforms_export'
      end
    end
  end

  match 'admin' => 'admin/news_items#index', via: [:get]

  resources :members, only: %i[index new create] do
    member do
      get 'mubc_account_details'
      get 'thankyou'
    end
  end

  post '/tinymce_assets' => 'admin/tinymce_assets#create'

  match 'sentry-error' => 'about#sentry_error', via: [:get]
  #  match 'members' => 'members#index', via: [:get]
  match 'membership' => 'members#new', via: [:get]
  match 'members/join_the_club' => 'members#new', :as => :join_the_club, via: [:get]
  match 'members/documents_and_forms' => 'members#documents_and_forms', :as => :documents_and_forms, via: [:get]
  match 'members/policies' => 'members#policies', :as => :policies, via: [:get]

  match 'news' => 'news#archived', :as => :archived_news, via: [:get]
  match 'news/:archived_year' => 'news#archived', :as => :archived_news_for_year, via: [:get]
  match 'news/:year/:article' => 'news#news_item', :as => :article, via: [:get]
  match 'authors/:author' => 'news#author', :as => :author, via: [:get]

  match 'dribbling_balls_newsletter' => 'news#dribbling_balls', as: :dribbling_balls, via: [:get]

  match 'domestic' => 'domestic#index', :as => :domestic, via: [:get]
  match 'domestic/uniforms' => 'domestic#uniforms', :as => :uniforms, via: [:get]

  match 'bigv' => 'bigv#index', :as => :bigv, via: [:get]
  match 'bigv/fixtures' => 'bigv#fixtures', :as => :bigv_fixtures, via: [:get]
  match 'bigv/teams' => 'bigv#teams', :as => :bigv_teams, via: [:get]

  match 'faq' => 'faq#index', :as => :faq, via: [:get]

  match 'about' => 'about#index', :as => :about, via: [:get]
  match 'about/contact_us' => 'about#contact_us', :as => :contact_us, via: [:get]
  match 'about/event_calendar' => 'about#event_calendar', :as => :event_calendar, via: [:get]
  match 'about/walkover_policy' => 'about#walkover_policy', :as => :walkover_policy, via: [:get]
  match 'about/insurance_claims_policy' => 'about#insurance_claims_policy', :as => :insurance_claims_policy, via: [:get]
  match 'about/code_of_conduct' => 'about#code_of_conduct', :as => :code_of_conduct, via: [:get]

  match 'about/sponsors' => 'about#sponsors', :as => :sponsors, via: [:get]
  match 'about/competition_titles_domestic' => 'about#competition_titles_domestic', :as => :competition_titles_domestic, via: [:get]
  match 'about/competition_results_big_v' => 'about#competition_results_big_v', :as => :competition_results_big_v, via: [:get]
  match 'about/competition_results_students' => 'about#competition_results_students', :as => :competition_results_students, via: [:get]
  match 'about/representative_mvps' => 'about#representative_mvps', :as => :representative_mvps, via: [:get]
  match 'about/team_mvps' => 'about#team_mvps', :as => :team_mvps, via: [:get]
  match 'about/most_improved_players' => 'about#most_improved_players', :as => :most_improved_players, via: [:get]
  match 'about/best_first_year_players' => 'about#best_first_year_players', :as => :best_first_year_players, via: [:get]
  match 'about/coaches_awards' => 'about#coaches_awards', :as => :coaches_awards, via: [:get]
  match 'about/bigv_league_awards' => 'about#bigv_league_awards', :as => :bigv_league_awards, via: [:get]
  match 'about/bigv_seasons' => 'about#bigv_seasons', :as => :bigv_seasons, via: [:get]
  match 'about/best_defensive_players' => 'about#best_defensive_players', :as => :best_defensive_players, via: [:get]
  match 'about/player_excellence_awards' => 'about#player_excellence_awards', :as => :player_excellence_awards, via: [:get]
  match 'about/teams_of_the_decades' => 'about#teams_of_the_decades', :as => :teams_of_the_decades, via: [:get]
  match 'about/blues_awards' => 'about#blues_awards', :as => :blues_awards, via: [:get]
  match 'about/green_and_gold_winners' => 'about#green_and_gold_winners', :as => :green_and_gold_winners, via: [:get]
  match 'about/committee' => 'about#committee', :as => :committee, via: [:get]
  match 'about/distinguished_service_awards' => 'about#distinguished_service_awards',
        :as => :distinguished_service_awards, via: [:get]
  match 'about/life_members' => 'about#life_members', :as => :life_members, via: [:get]

  root to: 'news#index', via: [:get]

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
