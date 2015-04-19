class AppEnvironmentResourcesController < ApplicationController
  before_action :set_app_environment_resource, only: [:edit, :update]

  # GET /app_environment_resources/1/edit
  def edit
  end

  # PATCH/PUT /app_environment_resources/1
  # PATCH/PUT /app_environment_resources/1.json
  def update
    respond_to do |format|
      if @app_environment_resource.update(app_environment_resource_params)
        format.html { redirect_to(
          app_environment_path(@app_environment_resource.app_environment_id),
          notice: 'App environment resource was successfully created.')
        }

        format.json { render :show, status: :ok, location: @app_environment_resource }
      else
        format.html { render :edit }
        format.json { render json: @app_environment_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_environment_resource
      @app_environment_resource = AppEnvironmentResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_environment_resource_params
      params.require(:app_environment_resource).permit(:app_environment_id, :app_resource_id, :count, :ami_id, :instance_type)
    end
end
