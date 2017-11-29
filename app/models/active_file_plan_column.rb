class ActiveFilePlanColumn < ActiveRecord::Base
  unloadable
  DEFAULT_ACTIVE_COLUMNS = %w(url
      functional_test
      test_in_ff
      test_in_ie
      test_in_ch
      test_in_sf
      test_in_mobile
      test_in_real_device
      internal_control
      client_note)

  ALL_COLUMNS = ['url',
                 'functional_test',
                 'test_in_ff',
                 'test_in_ch',
                 'test_in_ie',
                 'test_in_sf',
                 'test_in_mobile',
                 'test_in_real_device',
                 'raspberry',
                 'vega',
                 'thomson',
                 'android',
                 'ready_for_demo',
                 'internal_control',
                 'client_note']

  def self.active_columns(project)
    active_columns = where(project_id: project.id).active.pluck(:column_name)
    if active_columns.blank?
      active_columns = DEFAULT_ACTIVE_COLUMNS
    end
    active_columns
  end

  def self.active
    where(is_active: true)
  end
end
