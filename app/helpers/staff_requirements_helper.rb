module StaffRequirementsHelper
  def bar_style(size)
    size > 0 ? "width:#{number_to_percentage(size.to_f * 100, :precision=>1)}" : "display:none"
  end

  def compliance_alert_class(num,class_name)
    num > 0 ? class_name : "inactive"
  end

  def requirement_group_link(collection,names,key)
    unless key == "Unknown"
      name = names && names[BSON::ObjectID(key)] ? names[BSON::ObjectID(key)] : key
      if collection.dimension.name.to_s == "requirement_id"
        "<a href='admin/credentials/#{key}'>#{name}</a>"
      elsif collection.dimension.name.to_s == "requirement_set_id"
        "<a href='admin/requirement_sets/#{key}'>#{name}</a>"
      elsif %w(company_id region_id station_id transport_unit_id).include?(collection.dimension.name.to_s)
        "<a href='admin/organizational_units/#{key}'>#{name}</a>"  
      else
        name
      end
    else
      "Any in this set"
    end
  end
end
