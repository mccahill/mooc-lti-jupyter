require 'logger'
# This bitty class is needed so our logs will have timestamp info.
class ResourceLogger < Logger
  def format_message(severity, time, progname, msg)
    "%s| %s | %s: %s\n" % [time.strftime("%Y-%m-%d %H:%M:%S"),severity,Process.pid, msg]
  end
end

# # This logger allows us to log messages no matter how we are called.
# $RESOURCE_LOGGER = ResourceLogger.new('log/resource.log')

# This logger allows us to log messages no matter how we are called.
# In production, we may get loaded from an odd directory, so this will make sure we get the right file
$RESOURCE_LOGGER = ResourceLogger.new(File.absolute_path(File.join(File.dirname(__FILE__), '..', 'log/resource.log')))
