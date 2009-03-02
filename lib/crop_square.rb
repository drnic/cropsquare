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
    choppy_choppy(file, options)
  end
  
  def self.by_resolution(file, output_directory, resolution, options = {})
    self.new(file, output_directory, options.merge({:resolution => resolution}))
  end
  
  def choppy_choppy(file, options = {})
    resolution = (options[:resolution] ||= 1)
    while resolution >= 1
      raw_image ||= Image.read(file).first
      scale = resolution * 1.0 / options[:resolution]
      img = raw_image.thumbnail(scale)
      width = img.columns
      height = img.rows
      x_count = 0
      y_count = 0
      while (x = x_count * options[:size]) < width
        while (y = y_count * options[:size]) < height
          cropped = img.crop(x, y, options[:size], options[:size])
          cropped.write(File.join(@output_directory, "#{resolution}-#{"%02d" % x_count}-#{"%02d" % y_count}#{File.extname(file)}"))
          y_count += 1
        end
        x_count += 1
        y_count = 0
      end
      resolution /= 2
    end
  end
end