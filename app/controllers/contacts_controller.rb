class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
    
    respond_to do |format|
      format.js
      format.html
      format.json
      
    end
  end

  # GET /contacts/1 or /contacts/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  # GET /contacts/new
  def new
    @region = Region.find_by(id: params[:region].presence)
    @city = City.find_by(id: params[:city].presence)
    @suburb = Suburb.find_by(id: params[:suburb].presence)

    @regions = Region.all || []
    @cities = @region&.cities || []
    @suburbs = @city&.suburbs || []
    @dob = ''
    @contact = Contact.new
    respond_to do |format|
      format.html
      format.json
      format.js
    end
  end

  # GET /contacts/1/edit
  def edit
    @region = @contact.suburb.city.region
    @city = @contact.suburb.city
    @suburb = @contact.suburb
    @dob = @contact.birth_date.strftime("%Y-%m-%d").to_s

    @regions = Region.all
    @cities = @region&.cities || []
    @suburbs = @city&.suburbs || []
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)
    @contact.user = current_user

    @regions = Region.all
    @cities = @region&.cities || []
    @suburbs = @city&.suburbs || []

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    @contact.destroy
    respond_to do |format|
      format.html
      format.json
      format.js
    end

    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:fname, :lname, :phone, :birth_date, :email, :user_id, :suburb_id, :region_id, :city_id)
    end
end
