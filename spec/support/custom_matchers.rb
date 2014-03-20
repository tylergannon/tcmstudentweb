# RSpec::Matchers.define :fail_on do |method|
#   # chain :with_data do |data|
#   #   @data = data
#   # end
#   # 
#   # chain :returning do |return_message|
#   #   @expected_message = return_message
#   # end
# 
#   match do |controller|
#     
#     controller.stub(:data).and_return(@data || {})
#     def controller.failure_triggered?
#       !!@failure_triggered
#     end
#     def controller.failure_message
#       @failure_message
#     end
#     def controller.trigger_failure(message)
#       @failure_triggered = true
#       @failure_message = message
#     end
#     
#     # if @return_message
#     #   expectation.with(@return_message)
#     # end
#     
#     controller.send(method)
#     
#     @message = "Expected #{controller.class}/#{method} with data #{data} to trigger failure"
#     
#     if !controller.failure_triggered?
#       @message += " but failure was not triggered."
#       false
#     elsif @failure_message && (@failure_message != @expected_message)
#       @message += ".\nExpected message: #{@expected_message}\nReceived message: #{@failure_message}"
#       false
#     else
#       true
#     end
#   end
#   
#   failure_message_for_should do |controller|
#     @message
#   end
# end
