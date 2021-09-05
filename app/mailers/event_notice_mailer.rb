class EventNoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notice_mailer.notice.subject
  #
  
  default from: "abe.ayumu.infratop@gmail.com"
  
  def send_to_group_members(event_notice)
    @event_notice = event_notice
    @group = @event_notice.group
    @users = @group.users

    mail to: @group.owner.email,
         bcc: @users.pluck(:email),
         subject: @event_notice.title + "/" + @group.name
  end
end
