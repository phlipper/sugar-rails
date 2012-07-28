# sugar-rails

## Description

[Sugar](http://sugarjs.com/), tastefully bundled for the Rails 3.0 and up. Sweet!


## Requirements

This gem requires Rails 3.0+ and has been tested on the following versions:

* 3.0
* 3.1
* 3.2

This gem has been tested against the following Ruby versions:

* MRI 1.8.7
* REE 1.8.7
* 1.9.2
* 1.9.3
* JRuby
* Rubinius


## Installation

Add this line to your application's Gemfile:

```ruby
gem "sugar-rails"
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install sugar-rails
```


## Usage

`sugar-rails` supports both default and customized builds of Sugar.


### Rails 3.1+

For Rails 3.1 and greater, the files will be added to the asset pipeline and available for you to use.

To enable:

* Add the following line to the file `app/assets/javascripts/application.js` (or other [sprockets](https://github.com/sstephenson/sprockets) manifest):

``` javascript
//= require sugar
```

The following default builds are available:

* `sugar`                (default minified package)
* `sugar-full`           (full minified package)
* `sugar-development`    (full development package)


### Rails 3.0

This gem adds an installation generator to Rails 3, `sugar:install`. Running the generator will install the JavaScript file (default minified package) necessary to use Sugar.

* Invoke the generator:

```
$ rails generate sugar:install
```

* Add the following to your layout or view files:

```erb
<%= javascript_include_tag "sugar" %>
```


## Customized Builds

This gem adds a generator to provide customized builds of Sugar, `sugar:build`.

The `sugar:build` generator requires Rails 3.1+ and `config.assets.enabled = true` since custom builds are made available through the Rails Asset Pipeline.

Running the generator will create a customized JavaScript file with the pacakges of your choosing:

```
$ rails generate sugar:build package1 package2 ...
```

Once the generator has been run, you will be provided with the file `vendor/assets/javascripts/sugar-custom.js`. Add the following line to your sprockets manifest to enable your custom build:

``` javascript
//= require sugar-custom
```

By default, the `sugar:build` generator will provide the development (un-minified) sources. If you would like to use the pre-minified sources, add the `--minify` option to the generator:

```
$ rails generate sugar:build package1 package2 --minify
```

The following packages are available for custom builds:

* `es5` -  Shim methods that provide ES5 compatible functionality. This package can be excluded if you do not require legacy browser support (IE8 and below).
* `object` -  Object manipulation, type checking (isNumber, isString, ...), extended objects with hash-like methods available as instance methods.
* `array` -  Array manipulation and traversal, "fuzzy matching" against elements, alphanumeric sorting and collation, enumerable methods on Object.
* `number` -  Number formatting, rounding (with precision), and ranges. Aliases to Math methods.
* `regexp` -  Escaping regexes and manipulating their flags.
* `function` -  Lazy, throttled, and memoized functions, delayed functions and handling of timers, argument currying.
* `date` -  Date parsing and formatting, relative formats like "1 minute ago", Number methods like "daysAgo", localization support with default English locale definition.
* `date_ranges` -  Date Ranges define a range of time. They can enumerate over specific points within that range, and be manipulated and compared.
* `date_locales` -  Locale definitions: fr, it, es, pt, de, ru, pl, sv, ja, ko, zh-CN, zh-TW
* `string` -  String manupulation, escaping, encoding, truncation, and:conversion.
* `inflections` -  Pluralization similar to ActiveSupport including uncountable words and acronyms. Humanized and URL-friendly strings.
* `language` -  Normalizing accented characters, character width conversion, Hiragana and Katakana conversions.

Some dependencies must be met for your custom build to work properly:

* `date`   < `date_locales`
* `date`   < `date_ranges`
* `string` < `inflections`
* `string` < `language`

Run `rails generate sugar:build --help` for full usage instructions. Please visit [http://sugarjs.com/customize](http://sugarjs.com/customize) to learn more about customized builds.



## Contributing

1. [Fork it](https://github.com/phlipper/sugar-rails/fork_select)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a Pull Request](hhttps://github.com/phlipper/sugar-rails/pull/new)


## Contributors

Many thanks go to the following who have contributed to making this gem even better:

* **[@sandrew](https://github.com/sandrew)**
  * add support for customized builds for 1.2.x
* **[@andrewplummer](https://github.com/andrewplummer)**
  * add build generator to support customized builds in 1.3+
  * created [Sugar](https://github.com/andrewplummer/Sugar) :)


## License

**sugar-rails**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2011-2012/license.html).
* Copyright (c) 2011-2012 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)
* http://phlippers.net/

**Sugar**

* Freely distributable and licensed under the MIT-style license.
* Copyright (c) 2012 Andrew Plummer
* http://sugarjs.com/

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sub-license, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice, and every other copyright notice found in this software, and all the attributions in every file, and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
