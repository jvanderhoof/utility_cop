class AppEnvironmentsController < ApplicationController
  before_action :set_app_environment, only: [:show, :edit, :update, :destroy]
  before_action :set_app, only: [:index, :new]

  # GET /app_environments
  # GET /app_environments.json
  def index
  end

  # GET /app_environments/1
  # GET /app_environments/1.json
  def show
  end

  # GET /app_environments/new
  def new
    @app_environment = @app.app_environments.new
  end

  # GET /app_environments/1/edit
  def edit
  end

  # POST /app_environments
  # POST /app_environments.json
  def create
    @app_environment = AppEnvironment.new(app_environment_params)

    respond_to do |format|
      if @app_environment.save
        format.html { redirect_to app_environments_url(app_id: @app_environment.app_id), notice: 'App environment was successfully created.' }
        format.json { render :show, status: :created, location: @app_environment }
      else
        format.html { render :new }
        format.json { render json: @app_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_environments/1
  # PATCH/PUT /app_environments/1.json
  def update
    respond_to do |format|
      if @app_environment.update(app_environment_params)
        format.html { redirect_to app_environments_url(app_id: @app_environment.app_id), notice: 'App environment was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_environment }
      else
        format.html { render :edit }
        format.json { render json: @app_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_environments/1
  # DELETE /app_environments/1.json
  def destroy
    app_id = @app_environment.app_id
    @app_environment.destroy
    respond_to do |format|
      format.html { redirect_to app_environments_url(app_id: app_id), notice: 'App environment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_environment
      @app_environment = AppEnvironment.find(params[:id])
    end

    def set_app
      @app = App.find(params[:app_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_environment_params
      params.require(:app_environment).permit(:app_id, :environment_id, :git_tag)
    end
end
