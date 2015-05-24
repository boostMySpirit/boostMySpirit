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

  def boost
    @prayAlone = current_user.periodic_events.find_or_initialize_by(:eventType => 'prayAlone')
    if(@prayAlone.new_record?)
      @prayAlone.start = Time.now
    end
    ap @prayAlone
    
    @prayAlonePeriodicities = {
      'Tous les jours' => {
        :start => @prayAlone.start,
        :periodicity => 1.day.to_i
      }
    }
    if(@prayAlone.periodicity && @prayAlone.periodicity.seconds == 1.day)
      @prayAlonePeriodicities['Tous les jours'][:selected] = true
    end
    
    #Returns a hash. keys : english week days, values : locale week day
    translatedDayNames = Hash[Date::DAYNAMES.zip I18n.t('date.day_names')]
    
    #Populate for each days of week. Time.now.next_week.beginning_of_week gives the date of the day next week
    translatedDayNames.each do |dayName, dayNameLocalised|
      key = "Tous les #{dayNameLocalised}"
      @prayAlonePeriodicities[key] = {
        :start => Time.now.next_week.beginning_of_week + Date::DAYNAMES.index(dayName).days - 1.day,
        :periodicity => 1.week.to_i
      }
      if(@prayAlone.periodicity && @prayAlone.periodicity.seconds == 1.week && @prayAlone.start.strftime('%A') == dayName)
        @prayAlonePeriodicities[key][:selected] = true
      end
    end


    if(request.post?)
      @prayAlonePeriodicity =  @prayAlonePeriodicities[params["prayAlone"]["Periodicity"]]
      puts @prayAlonePeriodicity
      hour, minute = params["prayAlone"]["timepicker"].split(':')
      prayAloneStart = @prayAlonePeriodicity[:start].beginning_of_day + hour.to_i.hours + minute.to_i.minutes
      


      @prayAlone.start = prayAloneStart
      @prayAlone.periodicity = @prayAlonePeriodicity[:periodicity]
      logger.ap @prayAlone
      @prayAlone.save

      #Redirect back to reload controller
      redirect_to(:back) and return
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
