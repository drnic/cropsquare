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
      assert_equal(1, Dir[File.join(output_dir, "1-12-09.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "1-09-09.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "1-00-00.png")].length)    
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
      assert_equal(1, Dir[File.join(output_dir, "4-12-09.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "4-13-10.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "2-06-04.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "2-07-05.png")].length)
      assert_equal(1, Dir[File.join(output_dir, "1-03-02.png")].length)
      assert_equal(0, Dir[File.join(output_dir, "1-04-03.png")].length)
    end
    
    should "have 13*10 + 7*5 + 4*3 files generated" do
      assert_equal((Dir.entries(output_dir) - ['.', '..']).size, 13*10 + 7*5 + 4*3)
    end
  end
  
end
