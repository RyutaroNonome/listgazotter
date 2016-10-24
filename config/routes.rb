Rails.application.routes.draw do
# match "/auth/:provider/"         => "auth_sessions#auth"    # /auth/twitter
# match "/auth/:provider/callback" => "auth_sessions#create"  # /auth/twitter/callback
# match "/auth/signout"            => "auth_sessions#signout" # /auth/signout
    root 'auth_sessions#index'
    get '/auth/:provider/'           => 'auth_sessions#auth'
    get '/auth/:provider/callback'   => 'auth_sessions#create'
    # get '/auth/signout'              => 'auth_sessions#signout'
    get '/auth/:provider/signout'    => 'auth_sessions#signout'
end
