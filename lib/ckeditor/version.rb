module Ckeditor
  module Version
    MAJOR = 3
    MINOR = 5
    RELEASE = 4

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
