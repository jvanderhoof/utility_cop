class VpcsController < ApplicationController
  #before_action :set_vpc, only: [:show, :edit, :update, :destroy]

  # GET /vpcs
  # GET /vpcs.json
  def index
    @vpcs = Vpc.all
    #raise @vpcs.inspect
  end

  # GET /vpcs/1
  # GET /vpcs/1.json
  def show
  end

  # GET /vpcs/new
  def new
    @vpc = Vpc.new
  end

  # GET /vpcs/1/edit
  def edit
  end

  # POST /vpcs
  # POST /vpcs.json
  def create
    @vpc = Vpc.new(params[:name])

    respond_to do |format|
      if @vpc.save
        format.html { redirect_to vpcs_url, notice: 'Vpc was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /vpcs/1
  # PATCH/PUT /vpcs/1.json
  def update
    respond_to do |format|
      if @vpc.update(vpc_params)
        format.html { redirect_to @vpc, notice: 'Vpc was successfully updated.' }
        format.json { render :show, status: :ok, location: @vpc }
      else
        format.html { render :edit }
        format.json { render json: @vpc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vpcs/1
  # DELETE /vpcs/1.json
  def destroy
    @vpc.destroy
    respond_to do |format|
      format.html { redirect_to vpcs_url, notice: 'Vpc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vpc
      @vpc = Vpc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vpc_params
      params.require(:vpc).permit(:name)
    end
end
