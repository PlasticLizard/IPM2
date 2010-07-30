module StaffRequirementsHelper
  def bar_style(size)
    size > 0 ? "width:#{number_to_percentage(size.to_f * 100, :precision=>1)}" : "display:none"
  end

  def compliance_alert_class(num,class_name)
    num > 0 ? class_name : "inactive" 
  end
end
