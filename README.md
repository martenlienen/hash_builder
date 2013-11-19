# HashBuilder

This gem allows you to build hashes in a way, that is totally copied from
[json_builder](https://github.com/dewski/json_builder). I created this,
because json_builder does not allow extraction of partials, which I rely
heavily on, to keep my JSON generation DRY.
And while I was at it, I found it a good idea to increase the abstraction
level and build hashes instead of JSON because, this allows for easier
manipulation of the results, application in more different circumstances
and you can generate JSON and YAML with the well known `to_json` and
`to_yaml` methods from it.

## Installation

Add this line to your application's Gemfile:

    gem 'hash_builder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_builder

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
