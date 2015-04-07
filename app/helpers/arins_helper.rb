module ArinsHelper

  def request_link(message)
    body_txt = message.to_s.gsub("\r\n", '%0A').gsub("\n", '%0A')
    link_to 'Create Email', "mailto:#{@arin.mail_to}?subject=#{@arin.subject}&body=#{body_txt}", class: 'btn btn-primary', id: 'mail-link'
  end
end
