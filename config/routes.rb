EightyThousandHours::Application.routes.draw do
  resources :authentications do
    get 'create_new_account', :on => :collection
  end

  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => 'authentications#failure'

  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts',
                     :controllers => { :sessions => 'sessions',
                                       :registrations => 'registrations' }

  match '/accounts/merge' => 'users#merge'

  match '/blog/feed.atom' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }
  resources :posts, :path => 'blog' do
    collection do
      get :tag
      get :author
      get :vote
    end
  end

  resources :discussion_posts, :path => 'discussion'

  resources :comments

  resources :causes, :only => [:new,:create,:show,:index]
  resources :donations, :only => [:new,:create,:update,:show,:index,:edit]

  resources :votes, :only => [:new,:create,:delete]

  resources :supporters, :only => [:new, :create], :path => 'show-your-support'
  match 'show-your-support' => 'supporters#new'

  resources :chat_requests, :only => [:new,:create], :path => 'chat-to-us'
  match 'chat-to-us' => 'chat_requests#new'

  resources :career_advice_requests, :only => [:new,:create], :path => 'request-a-career-advice-session'
  match 'request-a-career-advice-session' => 'career_advice_requests#new'

  resources :endorsements, :only =>[:index]
  resources :videos, :only =>[:index]

  resources :etkh_profiles, :path => "members", :only => [:new,:create,:show,:index] do
    collection do
      post 'search'
      get 'email_list'
    end
  end
  match 'join' => 'etkh_profiles#join'

  resources :users, :path => 'accounts', :only => [:show,:edit,:update,:destroy] do
    resources :etkh_profiles 
    member do
      get 'posts'
    end
    collection do
      get 'all'
    end
  end

  resources :surveys, :only => [:show]

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
  match 'sitemap'       => 'pages#sitemap'
  match 'survey_test'   => 'pages#survey_test'
  resources :pages
  resources :pages, :path => '/', :only => [:show]
end
