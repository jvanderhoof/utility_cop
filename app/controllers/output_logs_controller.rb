class OutputLogsController < ApplicationController
  def show
    @log = OutputLog.find(params[:id])
  end
end
