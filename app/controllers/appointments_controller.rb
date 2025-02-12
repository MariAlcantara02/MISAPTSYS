class AppointmentsController < ApplicationController
    def new
      @appointment = Appointment.new
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @available_slots = Appointment.available_slots(@date)
    end
  
    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        redirect_to appointments_path, notice: "Appointment booked successfully!"
      else
        render :new
      end
    end
  
    def index
      @appointments = Appointment.all
    end

    def available_slots
        date = params[:date] ? Date.parse(params[:date]) : Date.today
        available_slots = Appointment.available_slots(date)
    
        events = available_slots.map do |slot|
          {
            title: 'Available',
            start: slot.iso8601,
            end: (slot + 30.minutes).iso8601
          }
        end
        render json: events
    end   
  
    private
  
    def appointment_params
      params.require(:appointment).permit(:firstname, :lastname, :department, :reasons, :appointment_date)
    end
  end