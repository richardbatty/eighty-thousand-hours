EightyThousandHours::Application.routes.draw do
  devise_for :users, :path => 'accounts'
  resources  :users, :path => 'accounts', :only => [:index, :show, :destroy]
  
  resources :posts

  # for creation of a new member profile
  # NOTE: this has to be before members/:name in routes
  match 'members/new' => 'members#new'

  # using friendly_id for url slugs like members/blogging-billy
  match 'members/:name'                 => 'members#show'

  # for the rest of the profile routes
  resources :members, :only             => [:index,:new,:create]

  root  :to                             => 'info#index'
  match 'ethical-career'                => 'info#ethical_career'
  match 'what-you-can-do'               => 'info#what_you_can_do'
  match 'what-you-can-do/my-donations'  => 'info#my_donations'
  match 'what-you-can-do/my-career'     => 'info#my_career'
  match 'what-we-do'                    => 'info#what_we_do'
  match 'volunteer'                     => 'info#volunteer'
  match 'faq'                           => 'info#faq'
  match 'get-involved'                  => 'info#get_involved'
  match 'get-involved/volunteer'        => 'info#volunteer'
  match 'events'                        => 'info#events'
  match 'events/past-events'            => 'info#past_events'
  match 'events/orbis-stockpicking-challenge' => 'info#orbis_stockpicking_challenge'
  match 'career-research'               => 'info#career_research'
  match 'contact-us'                    => 'info#contact_us'
  match 'the-pledge'                    => 'info#the_pledge'
  match 'help'                          => 'info#help'
end
