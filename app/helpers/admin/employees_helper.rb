module Admin::EmployeesHelper
  def requirement_status_image(requirement_status)
    case requirement_status.context_type
      when "RequirementSet" then image_tag("folder-bookmark.png")
      when "Credentials::Certification" then image_tag("medal.png")
      when "Credentials::License" then image_tag("credit_card.png")
      else nil
    end
  end
end
