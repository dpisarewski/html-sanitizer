This gem is a fork from [Rails Html Sanitizers](https://github.com/rails/rails-html-sanitizer) without rails dependency.

## Installation

Add this line to your application's Gemfile:

    gem 'html-sanitizer', github: 'dpisarewski/html-sanitizer'

And then execute:

    $ bundle

## Usage

### Sanitizers

All sanitizers respond to `sanitize`.

#### FullSanitizer

```ruby
full_sanitizer = Html::FullSanitizer.new
full_sanitizer.sanitize("<b>Bold</b> no more!  <a href='more.html'>See more here</a>...")
# => Bold no more!  See more here...
```

#### LinkSanitizer

```ruby
link_sanitizer = Html::LinkSanitizer.new
link_sanitizer.sanitize('<a href="example.com">Only the link text will be kept.</a>')
# => Only the link text will be kept.
```

#### WhiteListSanitizer

```ruby
white_list_sanitizer = Html::WhiteListSanitizer.new

# sanitize via an extensive white list of allowed elements
white_list_sanitizer.sanitize(@article.body)

# white list only the supplied tags and attributes
white_list_sanitizer.sanitize(@article.body, tags: %w(table tr td), attributes: %w(id class style))

# white list via a custom scrubber
white_list_sanitizer.sanitize(@article.body, scrubber: ArticleScrubber.new)

# white list sanitizer can also sanitize css
white_list_sanitizer.sanitize_css('background-color: #000;')
```

### Scrubbers

Scrubbers are objects responsible for removing nodes or attributes you don't want in your HTML document.

This gem includes two scrubbers `Html::PermitScrubber` and `Html::TargetScrubber`.

#### `Html::PermitScrubber`

This scrubber allows you to permit only the tags and attributes you want.

```ruby
scrubber = Html::PermitScrubber.new
scrubber.tags = ['a']

html_fragment = Loofah.fragment('<a><img/ ></a>')
html_fragment.scrub!(scrubber)
html_fragment.to_s # => "<a></a>"
```

#### `Html::TargetScrubber`

Where `PermitScrubber` picks out tags and attributes to permit in sanitization,
`Html::TargetScrubber` targets them for removal.


```ruby
scrubber = Html::TargetScrubber.new
scrubber.tags = ['img']

html_fragment = Loofah.fragment('<a><img/ ></a>')
html_fragment.scrub!(scrubber)
html_fragment.to_s # => "<a></a>"
```

#### Custom Scrubbers

You can also create custom scrubbers in your application if you want to.

```ruby
class CommentScrubber < Html::PermitScrubber
  def allowed_node?(node)
    !%w(form script comment blockquote).include?(node.name)
  end

  def skip_node?(node)
    node.text?
  end

  def scrub_attribute?(name)
    name == "style"
  end
end
```

See `Html::PermitScrubber` documentation to learn more about which methods can be overridden.

## Read more

Loofah is what underlies the sanitizers and scrubbers of rails-html-sanitizer.
- [Loofah and Loofah Scrubbers](https://github.com/flavorjones/loofah)

The `node` argument passed to some methods in a custom scrubber is an instance of `Nokogiri::XML::Node`.
- [`Nokogiri::XML::Node`](http://nokogiri.org/Nokogiri/XML/Node.html)
- [Nokogiri](http://nokogiri.org)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
