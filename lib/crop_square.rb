$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'rubygems'
require 'rmagick'
require "fileutils"
include Magick

class CropSquare
  VERSION = '0.0.1'
  def initialize(file, output_directory, size=128)
    FileUtils.mkdir_p(output_directory)
    img = Image.read(file)[0]
    width = img.columns
    height = img.rows
    x_count = 0
    y_count = 0
    while (x = x_count * size) < width
      while (y = y_count * size) < height
        cropped = img.crop(x, y, size, size)
        cropped.write(File.join(output_directory, "#{"%02d" % x_count}-#{"%02d" % y_count}.jpg"))
        y_count += 1
      end
      x_count += 1
      y_count = 0
    end
  end
end