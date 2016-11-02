class ReportMailer < ApplicationMailer
  default from: 'noreply@proconist.net'

  def receive_report_email(operator, report)
    mail to: operator.email, subject: '情報提供がありました' do |format|
      format.text { render locals: { report: report } }
    end
  end
end
