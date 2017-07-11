class Member
  include PubsubNotifier::Proxy

  subscribe :AdminNotifier
  subscribe :UserNotifier
end
