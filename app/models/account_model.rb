class AccountModel
    
  class << AccountModel
    def inherited(other)
      super
      other.send(:include,MongoMapper::Document)
      other.send(:include,InstanceMethods)
      other.key :account_id, ObjectId
      other.belongs_to :account

      other.timestamps!
      other.validates_presence_of :account
      other.before_validation :set_current_account


    end

    module InstanceMethods
      def set_current_account
        self.account = Account.current if Account.current
      end
    end   
  end
end