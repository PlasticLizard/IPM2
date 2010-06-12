module Services
  module EmployeeRequirements
    class ComplianceStatus

      attr_reader :context, :name
      attr_accessor :valid_until

      def initialize(name,context,options={})
        @name = name
        @context=context
        @valid_until = nil
        @incomplete = false
      end

      def compliant?
        return [:incomplete,:expired].exclude?(status)
      end

      def days_valid
        self.valid_until ? self.valid_until - Date.today : nil
      end

      def expiration_description
        return "Never Expires" unless self.valid_until
        if days_valid > 365 then valid_until
        elsif days_valid > 60
          "#{days_valid/30} Months"
        else
          "#{days_valid} Days"
        end
      end

      def status
        valid = days_valid
        return :incomplete if incomplete?
        return :current if valid.blank?
        return :expired if valid < 0
        return :expiration_imminent if valid <= 7
        return :expires_soon if valid <= 30
        return :current
      end

      def incomplete!
        @incomplete = true
      end

      def incomplete?
        @incomplete
      end

    end
  end
end