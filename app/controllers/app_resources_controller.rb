class AppResourcesController < ApplicationController
  before_action :set_app_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_app, only: [:index, :new]

  # GET /app_resources
  # GET /app_resources.json
  def index
  end

  # GET /app_resources/1
  # GET /app_resources/1.json
  def show
  end

  # GET /app_resources/new
  def new
    @app_resource = @app.app_resources.new
  end

  # GET /app_resources/1/edit
  def edit
  end

  # POST /app_resources
  # POST /app_resources.json
  def create
    @app_resource = AppResource.new(app_resource_params)

    respond_to do |format|
      if @app_resource.save
        format.html { redirect_to app_resources_url(app_id: @app_resource.app_id), notice: 'App resource was successfully created.' }
        format.json { render :show, status: :created, location: @app_resource }
      else
        format.html { render :new }
        format.json { render json: @app_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_resources/1
  # PATCH/PUT /app_resources/1.json
  def update
    respond_to do |format|
      if @app_resource.update(app_resource_params)
        format.html { redirect_to app_resources_url(app_id: @app_resource.app_id), notice: 'App resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_resource }
      else
        format.html { render :edit }
        format.json { render json: @app_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_resources/1
  # DELETE /app_resources/1.json
  def destroy
    app_id = @app_resource.app_id
    @app_resource.destroy
    respond_to do |format|
      format.html { redirect_to app_resources_url(app_id: app_id), notice: 'App resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_resource
      @app_resource = AppResource.find(params[:id])
    end

    def set_app
      @app = App.find(params[:app_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_resource_params
      params.require(:app_resource).permit(:app_id, :resource_id)
    end
end
