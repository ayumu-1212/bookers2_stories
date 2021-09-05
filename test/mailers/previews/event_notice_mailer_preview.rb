# Preview all emails at http://localhost:3000/rails/mailers/event_notice_mailer
class EventNoticeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/event_notice_mailer/notice
  def notice
    EventNoticeMailer.notice
  end

end
