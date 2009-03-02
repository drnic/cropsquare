require File.dirname(__FILE__) + '/test_helper.rb'

class TestCropSquare < Test::Unit::TestCase
  attr_reader :file, :output_dir
  
  def setup
    @file = File.expand_path(File.join(File.dirname(__FILE__), "fixtures", "model.jpg"))
    @output_dir = File.expand_path(File.join(File.dirname(__FILE__), "output"))
    FileUtils.rm_rf(output_dir)
  end
  
  def test_correct_number_of_images_generated
    CropSquare.new(file, output_dir)
    assert_equal(1, Dir[File.join(output_dir, "15-23.jpg")].length)
    assert_equal(1, Dir[File.join(output_dir, "09-09.jpg")].length)
    assert_equal(1, Dir[File.join(output_dir, "00-00.jpg")].length)
    assert_equal (Dir.entries(output_dir) - ['.', '..']).size, 24 * 16
  end
end
