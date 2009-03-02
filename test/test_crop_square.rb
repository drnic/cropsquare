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
      assert_equal(1, Dir[File.join(output_dir, "12-09-1.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "09-09-1.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "00-00-1.png")].length)    
    end
    
    should "have 13x10 files generated" do
      assert_equal((Dir.entries(output_dir) - ['.', '..']).size, 13 * 10)
    end
  end
  
  context "clone a model into alternate resolutions" do
    setup do
      @file = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "model.png"))
      @output_dir = File.expand_path(File.join(File.dirname(__FILE__), "output"))
      FileUtils.rm_rf(output_dir)
      CropSquare.by_resolution(file, output_dir, 4, { :size => 128 })
    end

    should "name its files XX-YY-LL.png" do
      assert_equal(1, Dir[File.join(output_dir, "12-09-4.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "13-10-4.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "06-04-2.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "07-05-2.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "03-02-1.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "04-03-1.png")].length)
    end
    
    should "have 13*10 + 7*5 + 4*3 files generated" do
      assert_equal((Dir.entries(output_dir) - ['.', '..']).size, 13*10 + 7*5 + 4*3)
    end
  end
  
end
