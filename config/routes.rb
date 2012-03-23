EightyThousandHours::Application.routes.draw do
  resources :authentications

  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts'

  match '/blog/feed.atom' => 'posts#feed', :as => :feed, :defaults => { :format => 'atom' }
  resources :posts, :path => 'blog', :only => [:index, :show] do
    collection do
      get :tag
      get :author
      get :vote
    end
  end

  resources :charities, :only => [:new,:create,:show,:index]
  resources :donations, :only => [:new,:create,:update,:show,:index,:edit]

  resources :votes, :only => [:new,:create,:delete]

  resources :supporters, :only => [:new, :create], :path => 'show-your-support'
  match 'show-your-support' => 'supporters#new'

  resources :chat_requests, :only => [:new,:create], :path => 'chat-to-us'
  match 'chat-to-us' => 'chat_requests#new'

  resources :endorsements, :only =>[:index]

  # override /members/new as /join
  match 'join'               => 'users#new', :as => :join
  match 'members/all'        => 'users#all', :as => :all
  match 'members/email-list' => 'users#email_list', :as => :all
  match 'members/search'     => 'users#search'
  match 'members/edit'       => 'users#edit'
  resources :users, :path    => "members"

  # renamed pages which we don't want to break existing links to
  match 'banker-vs-aid-worker' => redirect('/professional-philanthropy')

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
