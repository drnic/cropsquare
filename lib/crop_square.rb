$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'rmagick'
require 'fileutils'
include Magick

class CropSquare
  VERSION = '0.0.1'

  def initialize(file, output_directory, options = {})
    options[:size] ||= 128
    @output_directory = output_directory
    FileUtils.mkdir_p(@output_directory)
    choppy_choppy(file, nil, options)
  end
  
  def self.by_resolution(file, output_directory, resolution, options = {})
    original_image = Image.read(file).first
    self.new(file, output_directory, options)
  end
  
  def choppy_choppy(file, img = nil, options = {})
    options[:resolution] ||= 4
    img ||= Image.read(file).first
    width = img.columns
    height = img.rows
    x_count = 0
    y_count = 0
    while options[:resolution] >= 1
      while (x = x_count * options[:size]) < width
        while (y = y_count * options[:size]) < height
          cropped = img.crop(x, y, options[:size], options[:size])
          cropped.write(File.join(@output_directory, "#{"%02d" % x_count}-#{"%02d" % y_count}-#{options[:resolution]}#{File.extname(file)}"))
          y_count += 1
        end
        x_count += 1
        y_count = 0
      end
      puts "DID IT FOR #{options[:resolution]}"
      options[:resolution] /= 2
    end
  end
end