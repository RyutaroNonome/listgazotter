Rails.application.routes.draw do
# match "/auth/:provider/"         => "auth_sessions#auth"    # /auth/twitter
# match "/auth/:provider/callback" => "auth_sessions#create"  # /auth/twitter/callback
# match "/auth/signout"            => "auth_sessions#signout" # /auth/signout
    root 'auth_sessions#index'
    get '/auth/:provider/'           => 'auth_sessions#auth'
    get '/auth/:provider/callback'   => 'auth_sessions#create'
    # get '/auth/signout'              => 'auth_sessions#signout'
    get '/auth/:provider/signout'    => 'auth_sessions#signout'
    get 'list_link', to: 'list_timeline#listtimeline', as: 'listtimeline'
    get 'error_page', to: 'list_timeline#error_page', as: 'error_page'
    get 'mypage', to: 'list_timeline#mypage', as: 'mypage'
end