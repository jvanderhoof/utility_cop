class AppEnvironmentResourcesController < ApplicationController
  before_action :set_app_environment_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_app_environment, only: [:index, :new]

  # GET /app_environment_resources
  # GET /app_environment_resources.json
  def index
  end

  # GET /app_environment_resources/1
  # GET /app_environment_resources/1.json
  def show
  end

  # GET /app_environment_resources/new
  def new
    @app_environment_resource = @app_environment.app_environment_resources.new
  end

  # GET /app_environment_resources/1/edit
  def edit
  end

  # POST /app_environment_resources
  # POST /app_environment_resources.json
  def create
    @app_environment_resource = AppEnvironmentResource.new(app_environment_resource_params)

    respond_to do |format|
      if @app_environment_resource.save
        format.html { redirect_to(
          app_environment_resources_url(app_environment_id: @app_environment_resource.app_environment_id),
          notice: 'App environment resource was successfully created.')
        }
        format.json { render :show, status: :created, location: @app_environment_resource }
      else
        format.html { render :new }
        format.json { render json: @app_environment_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_environment_resources/1
  # PATCH/PUT /app_environment_resources/1.json
  def update
    respond_to do |format|
      if @app_environment_resource.update(app_environment_resource_params)
        format.html { redirect_to(
          app_environment_resources_url(app_environment_id: @app_environment_resource.app_environment_id),
          notice: 'App environment resource was successfully created.')
        }

        format.json { render :show, status: :ok, location: @app_environment_resource }
      else
        format.html { render :edit }
        format.json { render json: @app_environment_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_environment_resources/1
  # DELETE /app_environment_resources/1.json
  def destroy
    app_environment_id = @app_environment_resource.app_environment_id
    @app_environment_resource.destroy
    respond_to do |format|
      format.html { redirect_to app_environment_resources_url(app_environment_id: app_environment_id), notice: 'App environment resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_environment_resource
      @app_environment_resource = AppEnvironmentResource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_environment_resource_params
      params.require(:app_environment_resource).permit(:app_environment_id, :app_resource_id, :count, :ami_id)
    end

    def set_app_environment
      @app_environment = AppEnvironment.find(params[:app_environment_id])
    end
end
