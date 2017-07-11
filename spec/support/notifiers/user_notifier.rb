class UserNotifier < ApplicationNotifier
  def success(recipient)
    notify_success("#{recipient.class}##{__method__}")
  end

  def failure(recipient)
    notify_failure("#{recipient.class}##{__method__}")
  end

  def only_user(recipient)
    notify_success("#{recipient.class}##{__method__}")
  end
end
