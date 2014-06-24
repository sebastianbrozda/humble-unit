module Test
  module HumbleUnit
    module Outputs
      class BaseOutput
        def flush(messages)
          raise 'not implemented'
        end
      end
    end
  end
end