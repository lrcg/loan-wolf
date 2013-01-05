class EventLog < ActiveRecord::Base
	EVENT_TYPES = %w(transfer_create_unbound transfer_create_bound archive_transfer)
	attr_accessible :event_type, :hr_summary, :primary_model, :primary_model_id, :serialized_data
	validates_presence_of :event_type, :hr_summary, :primary_model, :primary_model_id
	validates :event_type, :inclusion => { :in => EVENT_TYPES }

	# 
	def primary_model_instance=(model)
		primary_model = model.class
		primary_model_id = model.id
	end

	class << self
		EVENT_TYPES.each do |t|
			method_name = 'new' + t.to_s.camelize
			define_method method_name do
				instance = EventLog.new
				instance.event_type = t
				instance
			end
		end
	end
end