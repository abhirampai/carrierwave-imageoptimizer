require "image_optimizer"
require "carrierwave-imageoptimizer/version"

module CarrierWave
  module ImageOptimizer
    DEFAULT_OPTIONS = {
      quiet: true,
      quality: 75,
      strip_metadata: false,
      level: 3
    }.frozen

    def optimize(options = {})
      ::ImageOptimizer.new(current_path, optimizer_options(options)).optimize
    end

    private

    def optimizer_options(options)
      DEFAULT_OPTIONS.dup.merge!(options)
    end
  end
end
