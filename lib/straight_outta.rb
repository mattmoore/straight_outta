require "straight_outta/version"
require "rmagick"

module StraightOutta
  def self.somewhere(location, file_path)
    spec = Gem::Specification.find_by_name('straight_outta')
    resource_path = "#{spec.gem_dir}/resources"

    background = Magick::Image.read("#{resource_path}/images/bg-black4.jpg").first
    frame = Magick::Image.read("#{resource_path}/images/logo-frame-2x.png").first
    grime = Magick::Image.read("#{resource_path}/images/pattern-grime.jpg").first

    x = (background.columns / 2) - (frame.columns / 2)
    y = (background.rows / 2) - (frame.rows / 2)

    # Composite background and frame
    result = background.composite!(frame, x, y, Magick::OverCompositeOp)

    # Text with grime
    text = Magick::Draw.new
    text.annotate(result, 768, 824, x, 406, location.upcase) do
      self.gravity = Magick::CenterGravity
      self.pointsize = 255
      self.font = "#{resource_path}/fonts/champion-htf-featherweight.ttf"
      self.font_weight = Magick::NormalWeight
      self.tile = grime
    end

    result.crop!(x, y, 768, 824)

    result.write(file_path)
  end
end
