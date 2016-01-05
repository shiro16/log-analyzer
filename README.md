# Log::Analyzer

[![Build Status](https://travis-ci.org/shiro16/log-analyzer.svg)](https://travis-ci.org/shiro16/log-analyzer)

Analyze the performance of each endpoint from the routing file

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log-analyzer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log-analyzer

## Usage

Rails Application:

    $ bundle exec rake log_analyzer:analyze

Other Framework Application:

    $ log-analyzer -r routing_file <file ...>

## CLI Reference

Help:

```shell
$ log-analyzer --help
Usage: log-analyzer [options] <file ...>
    -h, --help                       output usage information
    -V, --version                    output the version number
    -r FILE                          routing format file
    -S, --log-separator VALUE        log separator
    -R, --route-regexp VALUE         route regexp
    -L, --log-regexp VALUE           log regexp
```

Example:

```shell
$ log-analyzer -r path/to/routes.txt path/to/application.log
┏━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━┳━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━┓
┃ method ┃ endpoint   ┃ count ┃ response_time(avg) ┃ response_time(max) ┃ response_time(min) ┃
┣━━━━━━━━╊━━━━━━━━━━━━╊━━━━━━━╊━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━╊━━━━━━━━━━━━━━━━━━━━┫
┃ GET    ┃ /          ┃ 10    ┃ 20.5               ┃ 55                 ┃ 3                  ┃
┃ GET    ┃ /users     ┃ 5     ┃ 10.3               ┃ 30                 ┃ 3                  ┃
┃ GET    ┃ /users/:id ┃ 3     ┃ 10                 ┃ 15                 ┃ 5                  ┃
┃ POST   ┃ /users     ┃ 2     ┃ 30                 ┃ 40                 ┃ 20                 ┃
┃ DELETE ┃ /users/:id ┃ 0     ┃                    ┃                    ┃                    ┃
┗━━━━━━━━┻━━━━━━━━━━━━┻━━━━━━━┻━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━┛
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/log-analyzer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

