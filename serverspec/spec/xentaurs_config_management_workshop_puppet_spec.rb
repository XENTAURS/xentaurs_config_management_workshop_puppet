# For serverspec documentation - see http://serverspec.org/tutorial.html
require_relative '../spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe file ('/var/www/html/index.html') do
  it { should contain 'Automation for the People' }
end

describe port(80) do
  it { should be_listening.with('tcp') }
end
