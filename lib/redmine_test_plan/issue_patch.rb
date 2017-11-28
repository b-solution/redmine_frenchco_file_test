require_dependency 'issue'
module  RedmineTestPlan
  module IssuePatch
    def self.included(base)
      base.class_eval do
        has_one :test_plan
      end
    end
  end
end
