class TestPlan < ActiveRecord::Base
  unloadable
  belongs_to :issue
  include Redmine::SafeAttributes
  safe_attributes 'issue_id',
                  'functional_test',
                  'test_in_ff',
                  'test_in_ch',
                  'test_in_ie',
                  'test_in_sf',
                  'test_in_mobile',
                  'test_in_real_device',
                  'url',
                  'internal_control',
                  'client_note'

  RAS     = ['RAS',     0]
  PASS    = ['PASS',    1]
  PLANNED = ['PLANNED', 2]
  FAILED  = ['FAILED',  3]

  STATUS = [RAS, PASS, PLANNED, FAILED]

  validates_presence_of :issue_id



end
