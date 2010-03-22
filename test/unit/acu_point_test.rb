require 'test_helper'

class AcuPointTest < ActiveSupport::TestCase
  context "When parsing text attributes" do
    setup do
      @acu_point = AcuPoint.new(:english => "Lagger", :pinyin => "Screwball", :channel => Channel.first)
      @acu_point.acu_point_therapeutic_functions << AcuPointTherapeuticFunction.create(:therapeutic_function_name => "fuck_you")
      @acu_point.acu_point_therapeutic_functions << AcuPointTherapeuticFunction.create(:therapeutic_function_name => "fuck_you twice")
    end
    should "Be able to parse this" do
      assert(@acu_point.valid?, "AcuPoint must be valid for saving, in order for this test to work.")
      @acu_point = AcuPoint.create(ObjectHasher.hash_acu_point(@acu_point))
    end
  end
end