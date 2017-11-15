require "console_progress/version"

module ConsoleProgress
  class ETA
    ATTR = [:steps, :step, :step_time, :times,
            :avg_time, :format, :start_time,
            :hours, :minutes, :seconds,
            :message_prefix]

    attr_accessor *ATTR

    def initialize(steps, format: nil)
      @steps = steps
      @format = format
      @message_prefix = 'ETA'
      @format ||= "{{message_prefix}}: {{step}}/{{steps}} "\
                  "Time Left {{hours}}h or {{minutes}}m "\
                  "Took: {{step_time}}s Avg: {{avg_time}}s"
      @step = 0
      @times = []
    end

    def start
      @start_time = Time.now
      @step_time_start = @start_time
    end

    def progress(msg = nil, current_step: @step)
      @message_prefix = msg if msg
      t = Time.now
      @step_time = t - @step_time_start
      @times << @step_time
      @avg_time = @times.reduce(0, :+) / @times.size
      steps_left = @steps - @step
      @step = current_step + 1
      @seconds = steps_left * @avg_time
      @minutes = '%.2f' % (@seconds / 60)
      @hours = '%.2f' % (@seconds / 60 / 60)
      @step_time = '%.2f' % @step_time
      @avg_time = '%.2f' % @avg_time
      @step_time_start = t
      log
    end

    def log(msg = @message_prefix)
      out = @format.dup
      ATTR.each do |m|
        out.gsub!("{{#{m}}}", send(m).to_s)
      end
      out
    end
  end
end
