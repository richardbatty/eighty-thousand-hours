EightyThousandHours::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts'
  
  resources :posts, :path => 'blog', :only => [:index, :show]

  resources :supporters, :only => [:new, :create], :path => 'show-your-support'
  match 'show-your-support' => 'supporters#new'

  resources :chat_requests, :only => [:new,:create], :path => 'chat-to-us'
  match 'chat-to-us' => 'chat_requests#new'

  # override /members/new as /join
  match 'join'          => 'users#new', :as => :join
  match 'members/all'   => 'users#all', :as => :all
  resources :users, :path => "members"

  # pages which don't live in the database as they can't be
  # converted to pure Markdown
  match 'events'             => 'info#events'
  match 'events/past-events' => 'info#past_events'
  match 'meet-the-team'      => 'info#meet_the_team'
 
  # pages from old HIC site
  match 'ethical-career'                => 'info#banker_vs_aid_worker'
  match 'old-ethical-career'            => 'info#ethical_career'
  match 'what-you-can-do'               => 'info#what_you_can_do'
  match 'what-you-can-do/my-donations'  => 'info#my_donations'
  match 'what-you-can-do/my-career'     => 'info#my_career'
  match 'what-we-do'                    => 'info#what_we_do'
  match 'giving-more'                   => 'info#giving_more'

  # all other pages are stored as Markdown in the database
  root :to => 'pages#show', :id => "home"
  resources :pages
  resources :pages, :path => '/', :only => [:show]
end
