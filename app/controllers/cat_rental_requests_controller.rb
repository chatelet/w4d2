class CatRentalRequestsController < ApplicationController
  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(id: params[:cat_rental_request][:cat_id])
    else
      render text: "rental request fails", status: :unprocessable_entity
    end
  end

  def new
    @cats = Cat.all
    render :new
  end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
