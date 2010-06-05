module Services
  module EmployeeRequirements
    class ComplianceStatusBase

      def status
        raise NotImplementedError "status has not been implemented"
      end

      def compliant?
        return [:incomplete,:expired].exclude?(status)
      end

      def valid_until
        raise NotImplementedError "valid_until has not been impelemented"
      end

      def days_valid
        self.valid_until ? self.valid_until - Date.today : nil
      end
      
    end
  end
end