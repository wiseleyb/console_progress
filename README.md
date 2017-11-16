# ConsoleProgress

A simple gem to log progress on a job.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'console_progress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install console_progress

## Usage

```ruby
prog = ConsoleProgress::ETA.new(100)
prog.start
100.times do
  puts prog.progress
  sleep 2
end
```

Would output something like:
```
ETA: 1/100 Remainng: 0 Took: 0.00s Avg: 0.00s Elapsed: 0
ETA: 2/100 Remainng: 1:39 Took: 2.00s Avg: 1.00s Elapsed: 2
ETA: 3/100 Remainng: 2:10 Took: 2.00s Avg: 1.33s Elapsed: 4
ETA: 4/100 Remainng: 2:25 Took: 2.00s Avg: 1.50s Elapsed: 6
...
```

You can also do it every 10 steps by doing something like this:
```
prog = ConsoleProgress::ETA.new(100)
prog.start
100.times do |i|
  puts prog.progress(current_step: i) if i % 10 == 0
  sleep 2
end
```

Initialize with `number of steps`. Start it. Call `.progress` to move up a step.

You can override the default message prefix with `prog.message_prefix = 'Bob'`

You can override format by putting anything in `ConsoleProgress::ATTR` in a string with `{{}}` around it. Example:

```ruby
prog = ConsoleProgress.new(100, format: '{{step}}/{{steps}}'
or
set it later prog.format = '{{step}}/{{steps}}'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wiseleyb/console_progress.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

