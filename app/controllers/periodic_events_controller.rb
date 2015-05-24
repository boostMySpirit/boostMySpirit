class PeriodicEventsController < ApplicationController
  before_action :set_periodic_event, only: [:show, :edit, :update, :destroy]

  # GET /periodic_events
  # GET /periodic_events.json
  def index
    @periodic_events = PeriodicEvent.all
  end

  # GET /periodic_events/1
  # GET /periodic_events/1.json
  def show
  end

  # GET /periodic_events/new
  def new
    @periodic_event = PeriodicEvent.new
  end

  # GET /periodic_events/1/edit
  def edit
  end

  # POST /periodic_events
  # POST /periodic_events.json
  def create
    @periodic_event = PeriodicEvent.new(periodic_event_params)

    respond_to do |format|
      if @periodic_event.save
        format.html { redirect_to @periodic_event, notice: 'Periodic event was successfully created.' }
        format.json { render :show, status: :created, location: @periodic_event }
      else
        format.html { render :new }
        format.json { render json: @periodic_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periodic_events/1
  # PATCH/PUT /periodic_events/1.json
  def update
    respond_to do |format|
      if @periodic_event.update(periodic_event_params)
        format.html { redirect_to @periodic_event, notice: 'Periodic event was successfully updated.' }
        format.json { render :show, status: :ok, location: @periodic_event }
      else
        format.html { render :edit }
        format.json { render json: @periodic_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periodic_events/1
  # DELETE /periodic_events/1.json
  def destroy
    @periodic_event.destroy
    respond_to do |format|
      format.html { redirect_to periodic_events_url, notice: 'Periodic event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_periodic_event
      @periodic_event = PeriodicEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def periodic_event_params
      params.require(:periodic_event).permit(:eventType, :start, :end, :periodicity, :user_id)
    end
end
