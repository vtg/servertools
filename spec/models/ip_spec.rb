require "rspec"

describe Ip do

  context 'attributes' do
    it { should have_attribute(:address) }
    it { should have_attribute(:all_usable).with_default_value_of(0) }
    it { should have_attribute(:interface).with_default_value_of('eth0') }
    it { should have_attribute(:alias_num).with_default_value_of(0) }
  end

  context 'validations' do
    it { should have_valid(:interface).when('eth0', 'e12') }
    it { should_not have_valid(:interface).when('') }
    it { should have_valid(:alias_num).when('0') }
    it { should_not have_valid(:alias_num).when('') }
    it { should have_valid(:address).when('0') }
    it { should_not have_valid(:address).when('') }
  end

  context 'valid generation' do
    let(:ip) { Ip.new(address: "127.0.0.1/27\n128.0.0.1/27") }

    it { expect(ip.ranges.size).to eq 2 }
    it { expect(ip.mask(0)).to eq '255.255.255.224' }

    context 'all_usable false' do
      it { expect(ip.range(0).size).to eq 29 }
      it { expect(ip.range(0).first).to eq '127.0.0.2' }
      it { expect(ip.range(0).last).to eq '127.0.0.30' }
      it { expect(ip.range(1).size).to eq 29 }
      it { expect(ip.range(1).first).to eq '128.0.0.2' }
      it { expect(ip.range(1).last).to eq '128.0.0.30' }
    end

    context 'all_usable true' do
      before { ip.all_usable = 1 }

      it { expect(ip.range(0).size).to eq 32 }
      it { expect(ip.range(0).first).to eq '127.0.0.0' }
      it { expect(ip.range(0).last).to eq '127.0.0.31' }
      it { expect(ip.range(1).size).to eq 32 }
      it { expect(ip.range(1).first).to eq '128.0.0.0' }
      it { expect(ip.range(1).last).to eq '128.0.0.31' }
    end

  end

  context 'generation with duplicate' do
    let(:ip) { Ip.new(address: "127.0.0.1/27\n127.0.0.1/27") }

    it { expect(ip.ranges.size).to eq 1 }
    it { expect(ip.mask(0)).to eq '255.255.255.224' }

    context 'all_usable false' do
      it { expect(ip.range(0).size).to eq 29 }
      it { expect(ip.range(0).first).to eq '127.0.0.2' }
      it { expect(ip.range(0).last).to eq '127.0.0.30' }
    end

    context 'all_usable true' do
      before { ip.all_usable = 1 }

      it { expect(ip.range(0).size).to eq 32 }
      it { expect(ip.range(0).first).to eq '127.0.0.0' }
      it { expect(ip.range(0).last).to eq '127.0.0.31' }
    end
  end

  context 'generation with invalid range' do
    let(:ip) { Ip.new(address: "127.0.0/27") }

    it { expect(ip.invalid_ranges).to eq ['127.0.0/27'] }
    it { expect(ip.ranges.size).to eq 0 }
  end

  context 'generation with invalid and valid ranges' do
    let(:ip) { Ip.new(address: "127.0.0/27\n127.0.0.0/27") }

    it { expect(ip.invalid_ranges).to eq ['127.0.0/27'] }
    it { expect(ip.ranges.size).to eq 1 }
  end


  context 'results' do
    let(:ip) { Ip.new(address: "127.0.0.1/27\n128.0.0.1/27") }

    it { expect(ip.results.size).to eq 58 }
    it { expect(ip.results[0]).to eq "auto eth0:0\niface eth0:0 inet static\n\taddress 127.0.0.2\n\tnetmask 255.255.255.224" }
    it { expect(ip.results[1]).to eq "auto eth0:1\niface eth0:1 inet static\n\taddress 127.0.0.3\n\tnetmask 255.255.255.224" }
    it { expect(ip.results.last).to eq "auto eth0:57\niface eth0:57 inet static\n\taddress 128.0.0.30\n\tnetmask 255.255.255.224" }
    it { expect(ip.command).to eq 'for i in {0..57}; do ifup eth0:$i; done' }
  end

end
