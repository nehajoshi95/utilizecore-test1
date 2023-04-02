class ParcelsController < ApplicationController
  before_action :set_parcel, only: %i[ show edit update destroy ]

  # GET /parcels or /parcels.json
  def index
    @parcels = Parcel.all.paginate(:page => params[:page], :per_page => 20).order('id DESC')
  end

  # GET /parcels/1 or /parcels/1.json
  def show
  end

  # GET /parcels/new
  def new
    @parcel = Parcel.new
    # @users = User.all.map{|user| [user.name_with_address, user.id]}
    @sender = @parcel.build_sender
    @receiver = @parcel.build_receiver
    @sender.build_address
    @receiver.build_address
    @service_types = ServiceType.all.map{|service_type| [service_type.name, service_type.id]}
  end

  # GET /parcels/1/edit
  def edit
    @users = User.all.map{|user| [user.name_with_address, user.id]}
    @service_types = ServiceType.all.map{|service_type| [service_type.name, service_type.id]}
  end

  # POST /parcels or /parcels.json
  def create
    @parcel = Parcel.new(parcel_params)

    respond_to do |format|
      if @parcel.save
        format.html { redirect_to @parcel, notice: 'Parcel was successfully created.' }
        format.json { render :show, status: :created, location: @parcel }
      else
        format.html do
          @users = User.all.map{|user| [user.name_with_address, user.id]}
          @service_types = ServiceType.all.map{|service_type| [service_type.name, service_type.id]} 
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parcels/1 or /parcels/1.json
  def update
    respond_to do |format|
      if @parcel.update(parcel_params)
        format.html { redirect_to @parcel, notice: 'Parcel was successfully updated.' }
        format.json { render :show, status: :ok, location: @parcel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parcels/1 or /parcels/1.json
  def destroy
    @parcel.destroy
    respond_to do |format|
      format.html { redirect_to parcels_url, notice: 'Parcel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_csv_files
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parcel
      @parcel = Parcel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parcel_params
      params.require(:parcel).permit(:weight, :status, :service_type_id,
                                     :payment_mode, :sender_id, :receiver_id,
                                     :cost,sender_attributes: [:name, :email, address_attributes: [:address_line_one, :address_line_two, :city, :state, :country,:pincode, :mobile_number]],
         receiver_attributes: [:name, :email, address_attributes: [:address_line_one, :address_line_two, :city, :state, :country,:pincode, :mobile_number]])
    end
end
