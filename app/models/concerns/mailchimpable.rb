module Mailchimpable
  def create_segment(segment_name)
    return api_client.lists.static_segment_add({
      id: ENV['MAILCHIMP_LIST_ID'],
      name: segment_name
    })
  end

  def subscribe_to_list(email, merge_vars)
    begin
      api_client.lists.subscribe({
        id: ENV['MAILCHIMP_LIST_ID'],
        email: {email: email},
        merge_vars: merge_vars,
        double_optin: false,
        update_existing: false
      })
    rescue Exception => e
      logger.error(e)
    end
  end

  def subscribe_to_segment(segment_id, email)
    begin
      api_client.lists.static_segment_members_add({
        id: ENV['MAILCHIMP_LIST_ID'],
        seg_id: segment_id,
        batch: [{email: email}]
      })
    rescue Exception => e
      logger.error(e)
    end
  end

  def api_client
    return Gibbon::API.new
  end
end
