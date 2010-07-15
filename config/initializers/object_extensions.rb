require 'active_record_extensions'
ActiveRecord::Base.extend(TcmStudentWeb::ActiveRecordExtensions)
require 'haml/filters/tcm_textile'

