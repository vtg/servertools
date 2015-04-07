require 'spec_helper'

describe Arin do
  context 'attributes' do
    it { should have_attribute(:api_key) }
    it { should have_attribute(:comments) }
    it { should have_attribute(:customer_address) }
    it { should have_attribute(:customer_city) }
    it { should have_attribute(:customer_country) }
    it { should have_attribute(:customer_name) }
    it { should have_attribute(:customer_postal) }
    it { should have_attribute(:customer_state) }
    it { should have_attribute(:ip_address) }
    it { should have_attribute(:network_name) }
    it { should have_attribute(:origin) }
    it { should have_attribute(:private) }
    it { should have_attribute(:reg_action) }

    #it { should have_attribute(:alias_num).with_default_value_of(0) }
  end


  context 'validations' do
    #it { should have_valid(:interface).when('eth0', 'e12') }
    #it { should_not have_valid(:interface).when('') }
    #it { should have_valid(:alias_num).when('0') }
    #it { should_not have_valid(:alias_num).when('') }
    #it { should have_valid(:address).when('0') }
    #it { should_not have_valid(:address).when('') }
  end
end
