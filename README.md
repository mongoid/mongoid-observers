# Mongoid::Observers

[![Test](https://github.com/mongoid/mongoid-observers/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/mongoid/mongoid-observers/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/mongoid/mongoid-observers/badge.svg?branch=master)](https://coveralls.io/github/mongoid/mongoid-observers?branch=master)

Mongoid Observers (removed from core in Mongoid 4.0). Because this gem doesn't exist and I need to use it very often. Therefore, I extract the code from mongoid on my own. It's basically the same code from mongoid before it's removed.

## Installation

For Rails 5+, Add this line to your application's Gemfile:

    gem 'mongoid-observers', '~> 0.3.0'

For Rails 4 and below, Add this line to your application's Gemfile:

    gem 'mongoid-observers', '~> 0.2.0'

And then execute:

    $ bundle

## Usage

Observer classes respond to life cycle callbacks to implement trigger-like
behavior outside the original class. This is a great way to reduce the
clutter that normally comes when the model class is burdened with
functionality that doesn't pertain to the core responsibility of the
class. Mongoid's observers work similar to ActiveRecord's. Example:

```ruby
  class CommentObserver < Mongoid::Observer
    def after_save(comment)
      Notifications.comment(
        "admin@do.com", "New comment was posted", comment
      ).deliver
    end
  end
```

This Observer sends an email when a Comment#save is finished.

```ruby
  class ContactObserver < Mongoid::Observer
    def after_create(contact)
      contact.logger.info('New contact added!')
    end

    def after_destroy(contact)
      contact.logger.warn("Contact with an id of #{contact.id} was destroyed!")
    end
  end
```

This Observer uses logger to log when specific callbacks are triggered.

#### Observing a class that can't be inferred

Observers will by default be mapped to the class with which they share a
name. So CommentObserver will be tied to observing Comment,
ProductManagerObserver to ProductManager, and so on. If you want to
name your observer differently than the class you're interested in
observing, you can use the Observer.observe class method which takes
either the concrete class (Product) or a symbol for that class (:product):

```ruby
  class AuditObserver < Mongoid::Observer
    observe :account

    def after_update(account)
      AuditTrail.new(account, "UPDATED")
    end
  end
```

If the audit observer needs to watch more than one kind of object,
this can be specified with multiple arguments:

```ruby
  class AuditObserver < Mongoid::Observer
    observe :account, :balance

    def after_update(record)
      AuditTrail.new(record, "UPDATED")
    end
  end
```

The AuditObserver will now act on both updates to Account and Balance
by treating them both as records.

#### Available callback methods

* after_initialize
* before_validation
* after_validation
* before_create
* around_create
* after_create
* before_update
* around_update
* after_update
* before_upsert
* around_upsert
* after_upsert
* before_save
* around_save
* after_save
* before_destroy
* around_destroy
* after_destroy

#### Storing Observers in Rails

If you're using Mongoid within Rails, observer classes are usually stored
in `app/models` with the naming convention of `app/models/audit_observer.rb`.

#### Configuration

In order to activate an observer, list it in the `config.mongoid.observers`
configuration setting in your `config/application.rb` file.

```ruby
  config.mongoid.observers = :comment_observer, :signup_observer
```

Observers will not be invoked unless you define them in your
application configuration.

#### Loading

Observers register themselves with the model class that they observe,
since it is the class that notifies them of events when they occur.
As a side-effect, when an observer is loaded, its corresponding model
class is loaded.

Observers are loaded after the application initializers, so that
observed models can make use of extensions. If by any chance you are
using observed models in the initialization, you can
still load their observers by calling `ModelObserver.instance` before.
Observers are singletons and that call instantiates and registers them.

## Development

Run `bundle install` and `bundle exec rake`. Set `MONGOID_VERSION` and `RAILS_VERSION` before bundling to select another dependency combination, or use the files under `gemfiles/` with `BUNDLE_GEMFILE`. Set `MONGODB_HOST` to override `localhost:27017`.

Run `COVERAGE=true bundle install` followed by `COVERAGE=true bundle exec rake` to generate SimpleCov coverage in `coverage/`. GitHub Actions uploads the Ruby 4.0 job's report using the official Coveralls action.

Record user-visible changes in [CHANGELOG.md](CHANGELOG.md) under the next release, with an issue or pull request link when available and an author link. Danger checks changelog formatting on pull requests.

## Authors

* [Chamnap Chhorn](https://github.com/chamnap)
