module Services
  module EmployeeRequirements
    class ComplianceStatusGroup < ComplianceStatusBase

      attr_accessor :name, :children, :operator

      def initialize(name, options={})
        @name = name
        @children = {}
        @operator = options[:requires] || options[:operator] || :all
      end

      def status
        
      end

      def valid_until

      end
      
    end
  end
end
