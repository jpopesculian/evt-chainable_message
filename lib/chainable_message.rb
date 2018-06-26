require 'json'

module Messaging
  module Message
    class Metadata
      def reply_stream_name=(stream_name)
        begin
          result = reply_stream_list
        rescue
          result = []
        end
        if stream_name.is_a? String
          result.push(stream_name)
        else
          result = stream_name
        end
        @reply_stream_name = JSON.generate(result)
      end

      def reply_stream_name
        begin
          reply_stream_list.last
        rescue
          nil
        end
      end

      def reply_stream_list
        JSON.parse(@reply_stream_name)
      end

      def clear_reply_stream_name
        begin
          new_list = reply_stream_list
          result = new_list.pop()
          @reply_stream_name = JSON.generate(new_list)
        rescue
          reply_stream_name = []
        end
      end
    end
  end
end
