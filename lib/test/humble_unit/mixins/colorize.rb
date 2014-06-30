module Test
  module HumbleUnit
    module Mixins
      module Colorize
        def colorize(color_code)
          "\e[#{color_code}m#{self}\e[0m"
        end

        def to_red
          colorize(31)
        end

        def to_green
          colorize(32)
        end

        def to_blue
          colorize(34)
        end

        def to_brown
          colorize(33)
        end

        def bg_red
          colorize(41)
        end

        def bg_green
          colorize(42)
        end
      end
    end
  end
end

