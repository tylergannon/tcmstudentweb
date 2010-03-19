module TcmStudentWeb
  class Application < Rails::Application
    # ...Insert lots of example comments here...

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
  end
end