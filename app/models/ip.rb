require 'ipaddr'

class Ip
  include ActiveAttr::Model


  attribute :address, default: "127.0.0.1/27"
  attribute :all_usable, default: 0
  attribute :alias_num, default: 0
  attribute :interface, default: 'eth0'
  attribute :os, default: 'debian'
  attribute :range_num, default: 0


  validates :interface, presence: true
  validates :alias_num, presence: true
  validates :address, presence: true


  def initialize(*)
    super
    process_ranges if valid?
  end

  def ranges
    @ranges ||= []
  end

  def mask(range_num)
    @mask ||= { }
    @mask[range_num] ||= ranges[range_num].inspect.split('/').last.gsub('>', '')
  end

  def range(range_num)
    arr = ranges[range_num].to_range.to_a
    unless all_usable?
      2.times { arr.shift }
      arr.pop
    end
    arr
  end

  def invalid_ranges
    @invalid_ranges ||= []
  end

  def results
    @results ||= []
  end

  def command
    os == 'debian' ? debian_command : centos_command
  end

  private

  def all_usable?
    all_usable.to_i > 0
  end

  def process_ranges
    address.split("\n").each do |ip_line|
      ip_line.strip!
      begin
        new_range = IPAddr.new(ip_line)
        ranges << new_range unless ranges.include?(new_range)
      rescue
        invalid_ranges << ip_line
      end
    end
    process_results
  end

  def process_results
    if os == 'debian'
      ranges.each_with_index do |range, num|
        range(num).each do |ip|
          iface = "#{interface}:#{cur_alias}"
          results << "auto #{iface}\niface #{iface} inet static\n\taddress #{ip}\n\tnetmask #{mask(num)}"
          increase_alias
        end
      end
    else
      clone_num = alias_num.to_i
      ranges.each_with_index do |range, num|
        results << {
          file: "ifcfg-#{interface}-range#{range_num.to_i + num}",
          content: <<-FILE
          IPADDR_START=#{range(num).first}
          IPADDR_END=#{range(num).last}
          CLONENUM_START=#{clone_num}
          NETMASK=#{mask(num)}
          ONBOOT=yes
          FILE
        }
        clone_num += range(num).size
      end
    end
  end

  def increase_alias
    @cur_alias += 1
  end

  def cur_alias
    @cur_alias ||= alias_num.to_i
  end

  def debian_command
    "for i in {#{alias_num}..#{cur_alias-1}}; do ifup #{interface}:$i; done"
  end

  def centos_command
    'service network restart'
  end
end
