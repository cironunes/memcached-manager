require 'spec_helper'

describe Sinatra::MemcachedConnection do
  let(:klass) { Class.new.extend(Sinatra::MemcachedConnection) }

  context "#setup_memcached" do
    before(:each) { klass.setup_memcached 'localhost', '1337' }
    it { klass.should have_instance_variable(:memcached) }
  end

  context "#close_memcached" do
    before(:each) { klass.setup_memcached 'localhost', '1337' }

    # There isn't an Dalli api that tells if the connection is closed
    it { klass.respond_to? :close_memcached }
  end

  context "#memcached_connection" do
    before(:each) { klass.setup_memcached 'localhost', '1337' }

    it "should be the instance variable of memcached" do
      klass.instance_variable_get(:"@memcached").should be klass.memcached_connection
    end
  end
end
