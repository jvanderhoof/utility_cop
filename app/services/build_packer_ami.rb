class BuildPackerAmi
  attr_reader :output

  def initialize(packer_file, output_log_id=nil)
    @packer_file = File.join('packer_files', packer_file)
    raise "No File: #{self.packer_file}" unless File.exists?(self.packer_file)

    @output = (output_log_id) ? OutputLog.find(output_log_id) : OutputLog.create(name: "packer build: #{self.packer_file}")
    puts "output: #{self.output.id}"
  end

  def process
    ami_id = nil
    cmd = [
      "packer build",
      "-var 'aws_access_key=#{ENV['AWS_ACCESS_KEY_ID']}'",
      "-var 'aws_secret_key=#{ENV['AWS_SECRET_ACCESS_KEY']}'",
      self.packer_file
    ].join(' ')

    if valid?
      if ami = shell_out(cmd)
        ami_id = ami
        puts " --- AMI: #{ami}"
      end
    end
    ami_id
  end

  def valid?
    output = `packer validate #{self.packer_file}`
    if output.match(/Template validated successfully./)
      true
    else
      puts "Syntax errors: #{output}"
      false
    end
  end

  def shell_out(cmd)
    rtn = nil
    # big thanks to ehsanul - http://stackoverflow.com/questions/1154846/continuously-read-from-stdout-of-external-process-in-ruby
    require 'pty'
    begin
      PTY.spawn( cmd ) do |stdout, stdin, pid|
        begin
          #self.output.update_attribute(:log, )
          # Do stuff with the output here. Just printing to show it works
          stdout.each do |line|
            print line
            self.output.log += line
            self.output.save

            if line.match(/(ami-[\d\w]+)/)
              rtn = $1
            end
          end
        rescue Errno::EIO
          puts "Errno:EIO error, but this probably just means " +
                "that the process has finished giving output"
        end
      end
    rescue PTY::ChildExited
      puts "The child process exited!"
    end
    rtn
  end

protected
  attr_reader :packer_file

end