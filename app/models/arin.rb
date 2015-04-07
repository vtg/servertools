require 'ipaddr'

class Arin
  include ActiveAttr::Model

  attribute :api_key
  attribute :reg_action, default: 'N'
  attribute :network_name
  attribute :ip_address
  attribute :origin
  attribute :private, default: 'No'
  attribute :customer_name
  attribute :customer_address
  attribute :customer_city
  attribute :customer_state
  attribute :customer_postal
  attribute :customer_country
  attribute :comments
  attribute :mail_to, default: 'hostmaster@arin.net'
  attribute :subject, default: 'ARIN REASSIGN'


  def initialize(*)
    super
    process_ips if valid?
  end

  def results
    @results ||= []
  end

  def results1
    [
      'Template: ARIN-REASSIGN-SIMPLE-5.0',
      '** As of March 2011',
      '** Detailed instructions are located below the template.',
      '',
      "00. API Key: #{api_key}",
      "01. Registration Action (N,M, or R): #{reg_action}",
      "02. Network Name: #{network_name}",
      "03. IP Address and Prefix or Range: #{ip_address}",
      "04. Origin AS: #{origin}",
      "05. Private (Yes or No): #{private}",
      "06. Customer Name: #{customer_name}",
      "07. Customer Address: #{customer_address}",
      "08. Customer City: #{customer_city}",
      "09. Customer State/Province: #{customer_state}",
      "10. Customer Postal Code: #{customer_postal}",
      "11. Customer Country Code: #{customer_country}",
      "12. Public Comments: #{comments}",
      '',
      'END OF TEMPLATE'
    ]
  end

  private

  def process_ips
    arr = ip_address.to_s.split("\n").map { |x| x.to_s.strip }
    arr.delete('')
    return if arr.empty?
    if arr.size == 1
      results << result(arr.first)
    else
      results << result("#{arr.first} - #{arr.last}")
    end

    #ip_address.to_s.split("\n").each do |ip|
    #  ip.strip!
    #  first
    #  results << result(ip)
    #end
  end

  def result(ip)
    <<ESQ
Template: ARIN-REASSIGN-SIMPLE-5.0
** As of March 2011
** Detailed instructions are located below the template.

00. API Key: #{api_key}
01. Registration Action (N,M, or R): #{reg_action}
02. Network Name: #{network_name}
03. IP Address and Prefix or Range: #{ip}
04. Origin AS: #{origin}
05. Private (Yes or No): #{private}
06. Customer Name: #{customer_name}
07. Customer Address: #{customer_address}
08. Customer City: #{customer_city}
09. Customer State/Province: #{customer_state}
10. Customer Postal Code: #{customer_postal}
11. Customer Country Code: #{customer_country}
12. Public Comments: #{comments}

END OF TEMPLATE
ESQ
  end
end
