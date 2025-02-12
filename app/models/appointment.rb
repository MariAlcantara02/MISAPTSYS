class Appointment < ApplicationRecord
    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :department, presence: true
    validates :reasons, presence: true
    validates :appointment_date, presence: true
  
    # Custom validation to ensure appointment_date is in the future
    validate :appointment_date_cannot_be_in_the_past
  
    private
  
    def appointment_date_cannot_be_in_the_past
      if appointment_date.present? && appointment_date < Time.current
        errors.add(:appointment_date, "can't be in the past")
      end
    end

    # Define working hours and slot duration
    WORKING_HOURS = (8..17).to_a # 8 AM to 5 PM
    SLOT_DURATION = 30.minutes

    # Method to get available slots for a given date
    def self.available_slots(date)
    # Get all appointments for the given date
    existing_appointments = where(appointment_date: date.all_day).pluck(:appointment_date)

    # Generate all possible slots for the day
    all_slots = WORKING_HOURS.flat_map do |hour|
      [0, 30].map do |minute|
        Time.zone.parse("#{date} #{hour}:#{minute}")
      end
    end

    # Filter out slots that are already booked
    all_slots.reject do |slot|
      existing_appointments.any? { |appointment| appointment == slot }
    end
  end
  end