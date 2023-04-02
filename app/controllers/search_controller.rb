class SearchController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    if params[:search].present?
      @parcels = Parcel.where(id: params[:search])
    else
      @parcels = []
    end
  end
end
