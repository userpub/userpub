require 'spec_helper'

describe Account do
  subject{ build(:account) }
  
  describe '.find_by_env' do
    it 'should find by subdomain' do
      subject.save!
      expect(Account.find_by_env('SERVER_NAME' => [subject.subdomain, ENV['APP_HOST']].join('.'), 'SERVER_PORT' => 80)).to eq(subject)
    end
    
    it 'should find by host' do
      subject.host = 'custom.host.com'
      subject.save!
      expect(Account.find_by_env('SERVER_NAME' => 'custom.host.com', 'SERVER_PORT' => 80)).to eq(subject)
    end
  end
end
