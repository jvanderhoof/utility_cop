class AppCredentialsController < ApplicationController
  before_action :set_app_credential, only: [:show, :edit, :update, :destroy]
  before_action :set_app, only: [:index, :new]

  # GET /app_credentials
  # GET /app_credentials.json
  def index
    @app_credentials = AppCredential.where(app_id: params[:app_id])
  end





  # GET /app_credentials/1
  # GET /app_credentials/1.json
  def show
  end

  # GET /app_credentials/new
  def new
    @app_credential = @app.app_credentials.new

  end

  # GET /app_credentials/1/edit
  def edit
  end

  # POST /app_credentials
  # POST /app_credentials.json
  def create
    @app_credential = AppCredential.new(app_credential_params)

    respond_to do |format|
      if @app_credential.save
        format.html { redirect_to app_credentials_url(app_id: @app_credential.app_id), notice: 'App credential was successfully created.' }
        format.json { render :show, status: :created, location: @app_credential }
      else
        format.html { render :new }
        format.json { render json: @app_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_credentials/1
  # PATCH/PUT /app_credentials/1.json
  def update
    respond_to do |format|
      if @app_credential.update(app_credential_params)
        format.html { redirect_to app_credentials_url(app_id: @app_credential.app_id), notice: 'App credential was successfully updated.' }
        format.json { render :show, status: :ok, location: @app_credential }
      else
        format.html { render :edit }
        format.json { render json: @app_credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_credentials/1
  # DELETE /app_credentials/1.json
  def destroy
    app_id = @app_credential.app_id
    @app_credential.destroy
    respond_to do |format|
      format.html { redirect_to app_credentials_url(app_id: app_id), notice: 'App credential was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_credential
      @app_credential = AppCredential.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_credential_params
      params.require(:app_credential).permit(:app_id, :key, :text_value)
    end

    def set_app
      @app = App.find(params[:app_id])
    end

end
