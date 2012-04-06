EightyThousandHours::Application.routes.draw do
  resources :authentications do
    get 'create_new_account', :on => :collection
  end

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts'
  match '/accounts/merge' => 'users#merge'

  match '/blog/feed.atom' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }
  resources :posts, :path => 'blog' do
    collection do
      get :tag
      get :author
      get :vote
    end
  end

  resources :causes, :only => [:new,:create,:show,:index]
  resources :donations, :only => [:new,:create,:update,:show,:index,:edit]

  resources :votes, :only => [:new,:create,:delete]

  resources :supporters, :only => [:new, :create], :path => 'show-your-support'
  match 'show-your-support' => 'supporters#new'

  resources :chat_requests, :only => [:new,:create], :path => 'chat-to-us'
  match 'chat-to-us' => 'chat_requests#new'

  resources :endorsements, :only =>[:index]
  resources :videos, :only =>[:index]

  resources :eighty_thousand_hours_applications, :only =>[:new,:create]
  match 'join' => 'eighty_thousand_hours_applications#new'

  resources :eighty_thousand_hours_profiles, :path => "members", :only => [:show,:index] do
    collection do
      post 'search'
    end
  end

  resources :users, :path => 'accounts', :only => [:edit,:update,:destroy] do
    resources :eighty_thousand_hours_profiles 
    member do
      get 'posts'
    end
    collection do
      get 'all'
      get 'email_list'
    end
  end

  # pages which don't live in the database as they can't be
  # converted to pure Markdown
  match 'events'             => 'info#events'
  match 'events/past-events' => 'info#past_events'
 
  # pages from old HIC site
  match 'ethical-career'                => 'info#banker_vs_aid_worker'
  match 'old-ethical-career'            => 'info#ethical_career'
  match 'what-you-can-do'               => 'info#what_you_can_do'
  match 'what-you-can-do/my-donations'  => 'info#my_donations'
  match 'what-you-can-do/my-career'     => 'info#my_career'
  match 'what-we-do'                    => 'info#what_we_do'

  # all other pages are stored as Markdown in the database
  root :to => 'pages#show', :id => "home"
  match 'search'        => 'pages#search'
  match 'mailing-list'  => 'pages#mailing_list'
  match 'meet-the-team' => 'pages#meet_the_team'
  match 'sitemap'       => 'pages#sitemap'
  resources :pages
  resources :pages, :path => '/', :only => [:show]
end
