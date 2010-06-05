module Services
  module EmployeeRequirements
    class ComplianceStatus < ComplianceStatusBase

      attr_accessor :name, :valid_until, :incomplete

      def initialize(name)
        @name = name
        @valid_until = nil
        @incomplete = false
      end

      def status
        return :incomplete if incomplete
        return :current if days_valid.blank?
        return :expired if days_valid < 0
        return :expiration_imminent if days_valid <= 7
        return :expires_soon if days_valid <= 30
        return :current
      end

      def incomplete!
        @incomplete = true
      end
      
    end
  end
end
