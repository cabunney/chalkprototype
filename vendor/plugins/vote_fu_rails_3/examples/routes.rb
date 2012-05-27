
map.resources :users do |user|
  user.resources :votes
  user.resources :voteable do |mv|
    mv.resources :votes
  end
end

map.resources :users do |user|
  user.resources :pushes
  user.resources :pushable do |mv|
    mv.resources :pushes
  end
end