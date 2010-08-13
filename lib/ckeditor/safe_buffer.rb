module ActiveSupport #:nodoc:
  class SafeBuffer < String
    alias safe_concat concat

    def concat(value)
      if value.html_safe?
        super(value)
      else
        super(ERB::Util.h(value))
      end
    end
    alias << concat

    def +(other)
      dup.concat(other)
    end

    def html_safe?
      true
    end

    def html_safe
      self
    end

    def to_s
      self
    end

    def to_yaml(*args)
      to_str.to_yaml(*args)
    end
  end
end
