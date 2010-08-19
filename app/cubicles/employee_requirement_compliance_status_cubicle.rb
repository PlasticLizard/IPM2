class EmployeeRequirementComplianceStatusCubicle
  extend Cubicle::Aggregation

  source_collection "people",
                    :_type=>"Employee",
                    :requirement_compliance=>{"$ne"=>nil}

  expand :requirement_sets, :field_name=>'requirement_compliance.children'
  expand :requirements,     :expression=>'requirement_set.children[0].children'

  dimension :account_id

  dimension :employee_id, :field_name=>"_id"
  dimension :employee_name, :expression=>"this.last_name + ', ' + this.first_name"

  dimension :organizational_role_id
  dimension :department_id
  dimension :company_id,                 :field_name=>"organizational_unit_ids[0]"
  dimension :region_id,                  :field_name=>"organizational_unit_ids[1]"
  dimension :station_id,                 :field_name=>"organizational_unit_ids[2]"
  dimension :transport_unit_id,          :field_name=>"organizational_unit_ids[3]"

  dimension :requirement_set_status,     :expression=>'requirement_set.status'
  dimension :requirement_set_id,         :expression=>'requirement_set.context_id'
  dimension :requirement_set,            :expression=>'requirement_set.name'

  dimension :requirement_status,         :expression=>'requirement.status'
  dimension :requirement_id,             :expression=>'requirement.context_id'
  dimension :requirement,                :expression=>'requirement.name'
  dimension :mandatory,                  :expression=>'requirement.mandatory ? "Yes" : "No"'

  count     :total,                      :field_name=>"_id"
  count     :compliant,                  :field_name=>"_id", :condition=>"requirement.status != 'incomplete' && requirement.status != 'expired'"
  count     :current,                    :field_name=>"_id", :condition=>"requirement.status == 'current'"

  difference :non_compliant, :total,     :compliant
  difference :expiring_soon, :compliant, :current

  ratio     :compliance_pct,             :compliant, :total
  ratio     :current_pct,                :current,   :total

end