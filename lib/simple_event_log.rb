module SimpleEventLog
	extend ActiveSupport::Concern
	included do
		attr_accessible :event_type, :hr_summary, :primary_model, :primary_model_id, :serialized_data
		validates_presence_of :event_type, :hr_summary, :primary_model, :primary_model_id
		validates :event_type, :inclusion => { :in => EVENT_TYPES }
	end
end