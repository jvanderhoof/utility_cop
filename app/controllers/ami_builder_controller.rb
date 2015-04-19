class AmiBuilderController < ApplicationController
  def new
    @builders = Dir.entries(File.join(Rails.root, 'packer_files')).select{|i| i.match(/\.json\z/)}
  end

  def create
    if params[:builder_file].present?
      output_log = OutputLog.create(name: "packer build: #{params[:builder_file]}")
      BuildAmiWorker.perform_async(params[:builder_file], output_log.id)
      redirect_to output_log
    else
      redirect_to new_ami_builder_path
    end
  end
end
