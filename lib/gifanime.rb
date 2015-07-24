require "RMagick"
require "open-uri"

class Gifanime
  attr_accessor :frames, :delay, :iterations, :scene, :ticks_per_secound

  def initialize(options = {})
    @delay             = options[:delay]
    @iterations        = options[:iterations]
    @scene             = options[:scene]
    @ticks_per_secound = options[:ticks_per_secound]
    @frames = []
  end

  def add(frame)
    frames << ::Magick::Image.from_blob open(frame).read
  end

  def generate!
    gif = ::Magick::ImageList.new(*frames)
    gif.delay = delay if delay
    gif.iterations = iterations if iterations
    gif.scene = scene if scene
    gif.ticks_per_secound = ticks_per_secound if ticks_per_secound
    return gif.to_blob
  end
end

GifAnime = Gifanime
