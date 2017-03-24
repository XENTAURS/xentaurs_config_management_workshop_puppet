# for rspec-puppet documentation - see http://rspec-puppet.com/tutorial/
require_relative '../spec_helper'

describe 'xentaurs_config_management_workshop_puppet' do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemrelease => '6.6', :concat_basedir => '/var/tmp' } }
  it { should compile }
end
