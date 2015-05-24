class PeriodicEvent < ActiveRecord::Base
  belongs_to :user
  has_many :periodic_event_validates
  enum :event_type => [:pray_alone]

  def validatable_period?
    next_date = self.next_date
    return (next_date.to_date == Time.now.to_date) && (self.periodic_event_validates.where(:date => next_date.to_date).empty?)
  end

  def validate_period
    if(self.validatable_period?)
      self.periodic_event_validates.create(:date => next_date.to_date)
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
