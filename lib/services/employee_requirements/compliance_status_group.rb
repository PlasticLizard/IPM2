module Services
  module EmployeeRequirements
    class ComplianceStatusGroup < ComplianceStatus

      attr_reader :children, :operator
      
      def initialize(name, context, options={})
        super(name,context,options)
        @children = []
        @operator = options[:require] || options[:operator] || :all
        #start off incomplete, to be proven wrong
        incomplete! if @operator == :any
      end      

      def valid_until
        @operator==:all ? @first_expiring_child : @last_expiring_child
      end

      def << child
        self.incomplete! if child.incomplete? and operator == :all
        @incomplete = false if !(child.incomplete?) && operator == :any

        @first_expiring_child = child.valid_until if child.valid_until &&
                 (@first_expiring_child.blank? || child.valid_until < @first_expiring_child)

        @last_expiring_child = child.valid_until if child.valid_until &&
                (@last_expiring_child.blank? || child.valid_until > @last_expiring_child)

        @children << child
      end

    end
  end
end
