module Poster
  class Validator
    EXTENSIONS = /^\.m(d|arkdown)$/
    # DATES = /\d{4}_\d{2}_\d{2}/
    # BASENAME = /^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_])\.m(d|arkdown)$/

    def initialize(extensions = EXTENSIONS)
      @extensions = extensions
    end

    def valid_post_filename?(f)
      valid_extension?(f) && date_parseable(f) && not_a_dotfile(f)
    end

    def not_a_dotfile(f)
      File.basename(f)[0] != '.'
    end

    def valid_extension?(f)
      !!(@extensions =~ File.extname(f))
    end

    def date_parseable(f)
      basename = File.basename(f, File.extname(f))
      # Date#parse seems not to accept underscores as date delimiters
      sanitized = basename.gsub('_', '-')
      # This is far too lenient. I want dates to be digits only
      # But then I would need to vary delimiters
      # TODO: ask on SO how to make such date parsing with different delimiters
      !!Date.parse(sanitized) rescue false
    end
  end
end
