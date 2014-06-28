module Test
  module HumbleUnit
    module Outputs
      class BaseOutput
        def flush(messages, stats)
          raise 'not implemented'
        end
      end
    end
  end
end