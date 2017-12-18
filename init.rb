Redmine::Plugin.register :redmine_frenchco_file_test do
  name 'Redmine Frenchco File Test plugin'
  author 'Bilel kedidi'
  description 'This is a plugin for Redmine'
  version '0.1.3'
  url 'https://www.github.com/bilel-kedidi/redmine_frenchco_file_test'
  author_url 'https://www.github.com/bilel-kedidi'

  project_module :redmine_test_plan do
    permission :view_test_plan, :file_test => [:index, :create_or_update]
  end

  menu :project_menu, :redmine_test_plan, {:controller => 'file_test', :action => 'index' },
       caption: :redmine_test_plan,
       :if => Proc.new {
         User.current.allowed_to_globally?(:view_test_plan, {})
       },
       :after => :activity, param: :project_id

  Rails.application.config.to_prepare do
    Issue.send(:include, RedmineTestPlan::IssuePatch)
    ProjectsHelper.send(:include, RedmineTestPlan::ProjectsHelperPatch)
  end
end
