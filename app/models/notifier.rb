class Notifier < ActionMailer::Base
  default_url_options[:host] = "new_app_skeleton-app.com"
  FROM = "New Application <new_app_skeleton@ekohe.com>"

  def password_reset_instructions(user)
    subject       I18n.t("lost_password_email.subject")
    from          FROM
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def activation_instructions(user)
    subject       I18n.t("activation_instructions.subject")
    from          FROM
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => activate_url(user.perishable_token)
  end

  def activation_confirmation(user)
    subject       I18n.t("activation_confirmation.subject")
    from          FROM
    recipients    user.email
    sent_on       Time.now
    body          :home_url => home_url
  end
end