# frozen_string_literal: true
# encoding: UTF-8

class Fir
  module ScreenHelper
    def previous_line(n)
      "\e[#{n}F"
    end

    def next_line(n)
      "\e[#{n}E"
    end

    def horizontal_absolute(n)
      "\e[#{n}G"
    end

    def clear(n)
      "\e[#{n}K"
    end

    def line_prompt(prompt = '>')
      "(fir)#{prompt} "
    end
  end
end