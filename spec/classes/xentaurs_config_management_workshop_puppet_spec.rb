# for rspec-puppet documentation - see http://rspec-puppet.com/tutorial/
require_relative '../spec_helper'

describe 'xentaurs_config_management_workshop_puppet' do
  let(:facts) { { :osfamily => 'Redhat', :operatingsystemrelease => '6.6', :concat_basedir => '/var/tmp' } }
  let(:pre_condition){
    """
    Package {
      provider => 'yum',
    }
    """
  }
  it { should compile }
  it { is_expected.to contain_package('httpd')}
  it { is_expected.to contain_file('/var/www/html/index.html').with_content('Automation for the People')}
  it { is_expected.to contain_service('httpd').with_ensure('running')}
end
