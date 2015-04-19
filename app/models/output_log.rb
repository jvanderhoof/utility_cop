class OutputLog < ActiveRecord::Base
  def formatted_log_output
    self.log.gsub(/\r\n/, '<br />').gsub(/\[[1|0];32m|\[0m/, '').html_safe
  end
end
