class CancelsController < ApplicationController

  def update_noncancel
    cancel = Cancel.find(params[:id])
    cancel.update!(
      cancel: false
    )

    redirect_to supplies_path
  end

  def update_cancel
    cancel = Cancel.find(params[:id])
    cancel.update!(
      cancel: true
    )

    redirect_to supplies_path
  end

end
