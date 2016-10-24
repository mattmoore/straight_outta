require "straight_outta/version"
require "rmagick"

module StraightOutta
  def self.somewhere(location, file_path)
    location = location.upcase

    spec = Gem::Specification.find_by_name('straight_outta')
    resource_path = "#{spec.gem_dir}/resources"

    background = Magick::Image.read("#{resource_path}/images/bg-black4.jpg").first
    frame = Magick::Image.read("#{resource_path}/images/logo-frame-2x.png").first
    grime = Magick::Image.read("#{resource_path}/images/pattern-grime.jpg").first

    crop_x = (background.columns / 2) - (frame.columns / 2)
    crop_y = (background.rows / 2) - (frame.rows / 2)

    # Crop background to the frame
    background.crop!(crop_x, crop_y, frame.columns, frame.rows)

    # Composite background and frame
    result = background.composite(frame, 0, 0, Magick::OverCompositeOp)

    # User-specified location text
    gc = Magick::Draw.new
    gc.gravity = Magick::CenterGravity
    gc.font = "#{resource_path}/fonts/champion-htf-featherweight.ttf"
    gc.font_weight = Magick::NormalWeight
    pointsize = 250
    gc.pointsize = pointsize

    # Calculate pointsize down if text width is wider than the frame
    metrics = gc.get_type_metrics(location)
    while metrics[:width] > result.columns - 20
      pointsize = pointsize - 1
      gc.pointsize = pointsize
      metrics = gc.get_type_metrics(location)
    end

    gc.tile = grime
    gc_width = 0
    gc_height = 0
    gc_pos_x = 0
    gc_pos_y = 318
    gc.annotate(result, gc_width, gc_height, gc_pos_x, gc_pos_y, location)

    result.format = 'png'
    result.write(file_path)
  end
end
