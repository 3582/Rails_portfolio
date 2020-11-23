class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'task:message'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def task(data)
    ChatChannel.broadcast_to('message', deta['message'])
  end
end
