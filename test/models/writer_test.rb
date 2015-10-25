require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Writer Model" do
  it 'can construct a new instance' do
    @writer = Writer.new
    refute_nil @writer
  end
end
