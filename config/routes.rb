HighImpactCareers::Application.routes.draw do
  devise_for :users
  
  resources :posts
  resources :users, :only => [:index, :show]
  resources :profiles, :only => [:new, :create, :show, :index]
 
  root  :to                             => 'info#index'
  match 'ethical-career'                => 'info#ethical_career'
  match 'what-you-can-do'               => 'info#what_you_can_do'
  match 'what-you-can-do/my-donations'  => 'info#my_donations'
  match 'what-you-can-do/my-career'     => 'info#my_career'
  match 'what-we-do'                    => 'info#what_we_do'
  match 'volunteer'                     => 'info#volunteer'
  match 'faq'                           => 'info#faq'
  match 'get-involved'                  => 'info#get_involved'
  match 'get-involved/join'             => 'info#join'
  match 'get-involved/volunteer'        => 'info#volunteer'
  match 'events'                        => 'info#events'
  match 'events/past-events'            => 'info#past_events'
  match 'events/orbis-stockpicking-challenge' => 'info#orbis_stockpicking_challenge'
  match 'career-research'               => 'info#career_research'
  match 'pledge'                        => 'info#pledge'

  match 'contact-us'                    => 'info#contact_us'

  #match 'members'                       => 'info#members'
  #match 'members'                       => 'members#index'
  #match 'members/new'                   => 'members#new'

end
