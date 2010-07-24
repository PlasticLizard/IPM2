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

    def name_field
      :name
    end

    def get_names(criteria={})
      criteria[:account_id] = Account.current.id
      collection.find(criteria, {:fields=>{name_field=>1}}).inject({}){|hash,item|hash[item["_id"]]=item["name"];hash}
    end

    module InstanceMethods
      def set_current_account
        self.account = Account.current if Account.current
      end
    end   
  end
end