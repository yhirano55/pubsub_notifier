class User
  include PubsubNotifier::Proxy

  subscribe :AdminNotifier
  subscribe :UserNotifier
end
