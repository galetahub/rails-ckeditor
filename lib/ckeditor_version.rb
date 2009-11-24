module CkeditorVersion
  MAJOR = 1
  MINOR = 1
  RELEASE = 0

  def self.current
    "#{MAJOR}.#{MINOR}.#{RELEASE}"
  end
end
