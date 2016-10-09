class ReportMailer < ApplicationMailer
  default from: 'noreply@proconist.net'

  def receive_report_email(operator)
    mail to: operator.email, subject: '情報提供がありました'
  end
end
