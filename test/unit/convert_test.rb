require 'test_helper'
require 'convert'
require 'json'

class ConvertTest < ActiveSupport::TestCase
  def setup
    @json = JSON.parse(File.read(Rails.root.join('test', 'fixtures', 'users.json')))
  end


  test "to_csv matches with csv fixture" do
    assert_equal File.read(Rails.root.join('test', 'fixtures', 'users.csv')), Convert.to_csv(@json)
  end
end
