require 'time'

class SecretFile
  # attr_reader :data

  def initialize(secret_data, logger = SecurityLogger.new)
    @data = secret_data
    @access_log = logger
  end

  def access_data
    @access_log.create_log_entry
    puts @data
  end

  def print_access_log
    @access_log.print
  end
end

class SecurityLogger
  def initialize
    @log = []
  end

  def create_log_entry
    @log << "Accessed on #{Time.now}"
  end

  def print
    puts @log
  end
end

secret = SecretFile.new("Charming is cute")
secret.access_data
sleep(2)
secret.access_data
secret.print_access_log