json.array! @periodic_events.each do |periodic_event|
  json.event_type periodic_event.event_type
  json.event_type_pretty I18n.t("boost_my_spirit.periodic_events.#{periodic_event.event_type}")
  json.need_validation periodic_event.validatable_period?
  json.next_validation periodic_event.next_validation
  json.last_validation periodic_event.last_validation

end