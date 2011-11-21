EightyThousandHours::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :users, :path => 'accounts'
  resources  :users, :path => 'accounts'
  
  resources :posts

  # for the rest of the profile routes
  resources :members

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
end
