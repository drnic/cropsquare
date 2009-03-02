require File.dirname(__FILE__) + '/test_helper.rb'

class TestCropSquare < Test::Unit::TestCase
  attr_reader :file, :output_dir
  
  context "chop chop a model" do
    setup do
      @file = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "model.png"))
      @output_dir = File.expand_path(File.join(File.dirname(__FILE__), "output"))
      FileUtils.rm_rf(output_dir)
      CropSquare.new(file, output_dir)
    end

    should "name its files XX-YY.png" do
      assert_equal(1, Dir[File.join(output_dir, "12-09.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "09-09.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "00-00.png")].length)    
    end
    
    should "have 13x10 files generated" do
      assert_equal((Dir.entries(output_dir) - ['.', '..']).size, 13 * 10)
    end
  end
end
