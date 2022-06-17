class SchedulesController < ApplicationController
  before_action :set_schedule, only: %i[ show edit update destroy ]

  # GET /schedules or /schedules.json
  def index
    @order = Order.find(params[:format])
    @schedules = Schedule.where(order_id: @order.id).order(date: "ASC")
  end

  def index_day
    @day = params[:day] ? Date.parse(params[:day]) : Time.zone.today
    @schedules = Schedule.where(date: @day.all_day).where(check_list: 0)
    @schedules_check = Schedule.where(date: @day.all_day).where(check_list: 1)
  end


  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
    @order = Order.find(params[:order])

  end

  # GET /schedules/1/edit
  def edit
    @order = Order.find(params[:order])
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to schedules_url(@schedule.order_id), notice: "スケジュールを作成しました" }
        format.json { render :show, status: :created, location: @schedule }
      else
        @order = Order.find(@schedule.order_id)
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to schedules_url(@schedule.order_id), notice: "スケジュールを更新しました" }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_check
    @schedule = Schedule.find(params[:id])
    @schedule.update!(check_list: 1)
    redirect_to schedules_url(@schedule.order_id)
  end

  def update_noncheck
    @schedule = Schedule.find(params[:id])
    @schedule.update!(check_list: 0)
    redirect_to schedules_url(@schedule.order_id)
  end

  def update_check_task
    @schedule = Schedule.find(params[:id])
    @schedule.update!(check_list: 1)
    redirect_to index_day_schedules_url(@schedule.order_id)
  end

  def update_noncheck_task
    @schedule = Schedule.find(params[:id])
    @schedule.update!(check_list: 0)
    redirect_to index_day_schedules_url(@schedule.order_id)
  end


  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to schedules_url(@schedule.order_id), notice: "スケジュールを削除しました" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:date, :what, :do, :check_list, :order_id)
    end
end
