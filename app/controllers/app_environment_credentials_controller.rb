class AppEnvironmentCredentialsController < ApplicationController
  before_action :set_app_environment_credential, only: [:show, :edit, :update, :destroy]

  # GET /app_environment_credentials
  # GET /app_environment_credentials.json
  def index
    @app_environment_credentials = AppEnvironmentCredential.all
  end

  # GET /app_environment_credentials/1
  # GET /app_environment_credentials/1.json
  def show
  end

  # GET /app_environment_credentials/new
  def new
    @app_environment_credential = AppEnvironmentCredential.new
  end

  # GET /app_environment_credentials/1/edit
  def edit
  end

  # POST /app_environment_credentials
  # POST /app_environment_credentials.json
  def create
    @app_environment_credential = AppEnvironmentCredential.new(app_environment_credential_params)

    respond_to do |format|
      if @app_environment_credential.save
        format.html { redirect_to @app_environment_credential, notice: 'App environment credential was successfully created.' }
        format.json { render :show, status: :created, location: @app_environment_credential }
      else
        format.html { render :new }
        format.json { render json: @app_environment_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_environment_credentials/1
  # PATCH/PUT /app_environment_credentials/1.json
  def update
    respond_to do |format|
      if @app_environment_credential.update(app_environment_credential_params)
        format.html { redirect_to @app_environment_credential, notice: 'App environment credential was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_environment_credential }
      else
        format.html { render :edit }
        format.json { render json: @app_environment_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_environment_credentials/1
  # DELETE /app_environment_credentials/1.json
  def destroy
    @app_environment_credential.destroy
    respond_to do |format|
      format.html { redirect_to app_environment_credentials_url, notice: 'App environment credential was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_environment_credential
      @app_environment_credential = AppEnvironmentCredential.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_environment_credential_params
      params.require(:app_environment_credential).permit(:credential_id, :app_environment_id, :encrypted_value, :text_value)
    end
end
