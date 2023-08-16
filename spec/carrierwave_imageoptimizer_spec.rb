require 'spec_helper'

describe CarrierWave::ImageOptimizer do
  describe '#optimize' do
    before do
      @uploader = Class.new do
        include CarrierWave::ImageOptimizer
        def current_path; '/tmp/path/to/image.jpg' end
      end
    end

    it 'delegates to a new instance of ImageOptimizer with the current path to the file' do
      initialize_image_optimizer
      @uploader.new.optimize
    end

    it 'accepts an optional quality param to target a specific lossy JPG quality level' do
      initialize_image_optimizer({ quality: 99 })
      @uploader.new.optimize(quality: 99)
    end

    it 'accepts an optional quiet param to run in quiet mode' do
      initialize_image_optimizer({ quiet: true })
      @uploader.new.optimize(quiet: true)
    end

    it 'has default values for quiet, quality, level and skip_metadata' do
      initialize_image_optimizer
      @uploader.new.optimize(quiet: true, quality: 75, level: 3, strip_metadata: false)
    end

    private

    def initialize_image_optimizer(options = {})
      image_optimizer = double(::ImageOptimizer)
      expect(::ImageOptimizer).to receive(:new).with('/tmp/path/to/image.jpg', optimizer_options(options)).and_return(image_optimizer)
      expect(image_optimizer).to receive(:optimize)
    end

    def optimizer_options(options)
      CarrierWave::ImageOptimizer::DEFAULT_OPTIONS.dup.merge!(options)
    end
  end
end
