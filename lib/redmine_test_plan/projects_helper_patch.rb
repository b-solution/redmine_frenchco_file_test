require_dependency 'projects_helper'
module  RedmineTestPlan
  module ProjectsHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :project_settings_tabs, :test_file
      end
    end
  end
  module InstanceMethods
    def project_settings_tabs_with_test_file
      tabs = project_settings_tabs_without_test_file
      if User.current.admin?
        tabs << {:name => 'test_file', :action => :manage_test_files, :partial => 'projects/settings/test_file', :label => :redmine_test_plan}
      end
      tabs
    end
  end
end
