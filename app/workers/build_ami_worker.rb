class BuildAmiWorker
  include Sidekiq::Worker

  def perform(packer_file, output_log_id)
    BuildPackerAmi.new(packer_file, output_log_id).process
  end
end