class PeriodicEvent < ActiveRecord::Base
  belongs_to :user
  has_many :periodic_event_validates
  enum :event_type => [:pray_alone]

  def validatable_period?
    next_date = self.next_date
    return (next_date.to_date == Time.now.to_date) && (Time.now > next_date) && (self.periodic_event_validates.where(:date => next_date.to_date).empty?)
  end

  def validate_period
    if(self.validatable_period?)
      self.periodic_event_validates.create(:date => next_date.to_date)
    end
  end

  def last_validation
    if(last_validation = self.periodic_event_validates.order(:date).last)
      return last_validation.created_at
    else
      return false
    end
  end

  def next_validation
    #If start date is in the futre, we return start date
    if(self.start > Time.now)
      return self.start
    #If start date is today and if it was validated, we return next period
    elsif(self.start.today? && !self.validatable_period?)
      return Time.now.beginning_of_day + self.start.strftime('%H').to_i.hours + self.start.strftime('%M').to_i.minutes + self.periodicity.seconds
    else
      return self.start + (((Time.now.to_date - self.start.to_date).to_i.days.to_i / self.periodicity.to_f).ceil * self.periodicity).seconds
    end
  end


  def next_date
    #If start date is today or in the futre, we return start date
    if(self.start.today? || self.start > Time.now)
      return self.start
    else
      #Calculate the next date of the event as from today
      return self.start + (((Time.now.to_date - self.start.to_date).to_i.days.to_i / self.periodicity.to_f).ceil * self.periodicity).seconds
    end
  end
end
