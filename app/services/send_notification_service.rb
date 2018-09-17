class SendNotificationService < BusinessProcess::Base
  needs :resource_ids
  needs :resource_type
  needs :target_id
  needs :type
  needs :title
  needs :text
  needs :data

  steps :send_push_notifications

  def call
    process_steps
  end

  private
    def send_push_notifications
      devices = JeraPush::Device.where("pushable_type = ? AND pushable_id in (?)", resource_type, resource_ids)
      if !devices.empty?
        content = { 
          body: text, 
          title: title, 
          type: type, 
          target_id: target_id, 
          data: data
        }
        JeraPush::Message.send_to(devices, content: content)
      end
    end
end
