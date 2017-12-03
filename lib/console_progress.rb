require "console_progress/version"

module ConsoleProgress
  class ETA
    ATTR = [:steps, :step, :step_time, :times,
            :avg_time, :format, :start_time,
            :seconds, :message_prefix,
            :elapsed_time, :time_left]

    attr_accessor *ATTR

    def initialize(steps, format: nil, current_step: 0)
      @steps = steps
      @format = format
      @message_prefix = 'ETA'
      @format ||= "{{message_prefix}}: {{step}}/{{steps}} "\
                  "Remaining: {{time_left}} "\
                  "Took: {{step_time}}s Avg: {{avg_time}}s "\
                  "Elapsed: {{elapsed_time}}"
      @step = current_step
      @times = []
      start
    end

    def start
      @start_time = Time.now
      @step_time_start = @start_time
    end

    def progress(msg = nil, current_step: @step)
      @message_prefix = msg if msg
      t = Time.now
      @step_time = t - @step_time_start

      @elapsed_time = seconds_to_time(t - @start_time)

      @times << @step_time
      # @avg_time =  @times.reduce(0, :+) / @times.size
      @avg_time = median(@times)

      steps_left = @steps - @step
      @step = current_step + 1

      @seconds = steps_left * @avg_time
      @time_left = seconds_to_time(@seconds)

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

    def put_if(limit)
      out = progress
      puts out if @step % limit == 0
    end

    def seconds_to_time(t)
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      [dd, hh, mm, ss].delete_if {|r| r == 0}
        .map {|r| '%02d' % r.to_i}
        .join(':')
    end

    # from https://stackoverflow.com/posts/14859546/revisions
    def median(array)
      sorted = array.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    def self.example
      eta = ConsoleProgress::ETA.new(100)
      eta.start
      100.times do
        sleep 2
        puts eta.progress
      end
    end

    def self.example2
      eta = ConsoleProgress::ETA.new(100)
      eta.start
      100.times do
        sleep 1
        eta.put_if(10)
      end
    end
  end
end
