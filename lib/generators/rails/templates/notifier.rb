<% module_namespacing do -%>
class <%= class_name %>Notifier < ApplicationNotifier
  use :slack

  def success(recipient)
    record = recipient
    notify_success("#{record} has successfully created.")
  end

  def failure(recipient)
    record = recipient
    notify_failure("#{record} cannot created.")
  end
end
<% end -%>
