class SuburbsController < ApplicationController
  before_action :set_suburb, only: %i[ show edit update destroy ]

  # GET /suburbs or /suburbs.json
  def index
    @suburbs = Suburb.all
  end

  # GET /suburbs/1 or /suburbs/1.json
  def show
  end

  # GET /suburbs/new
  def new
    @suburb = Suburb.new
  end

  # GET /suburbs/1/edit
  def edit
  end

  def suburb_query
    @city_suburbs = City.find(params[:city_id]).suburbs
    render json: @city_suburbs
  end

  # POST /suburbs or /suburbs.json
  def create
    @suburb = Suburb.new(suburb_params)
    @suburb.user = current_user

    respond_to do |format|
      if @suburb.save
        format.html { redirect_to suburb_url(@suburb), notice: "Suburb was successfully created." }
        format.json { render :show, status: :created, location: @suburb }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @suburb.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suburbs/1 or /suburbs/1.json
  def update
    respond_to do |format|
      if @suburb.update(suburb_params)
        format.html { redirect_to suburb_url(@suburb), notice: "Suburb was successfully updated." }
        format.json { render :show, status: :ok, location: @suburb }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @suburb.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suburbs/1 or /suburbs/1.json
  def destroy
    @suburb.destroy

    respond_to do |format|
      format.html { redirect_to suburbs_url, notice: "Suburb was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suburb
      @suburb = Suburb.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suburb_params
      params.require(:suburb).permit(:name, :city_id, :user_id)
    end
end
