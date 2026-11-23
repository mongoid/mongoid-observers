# Contributing to Mongoid::Observers

Run `bundle install`, then `bundle exec appraisal mongoid_9 bundle install` and `bundle exec appraisal mongoid_9 rake`. `Appraisals` defines supported Mongoid/Rails pairs; select another appraisal with a compatible Ruby, or use its generated Gemfile with `BUNDLE_GEMFILE`. Set `MONGODB_HOST` to override `localhost:27017`.

The default task runs unit specs and a separate Rails integration suite. Run only the fixture application's tests with `bundle exec appraisal mongoid_9 rake integration`. These boot a real Rails application, persist observed records, and verify observer registration after Rails unloads and reloads the model classes.

Run `COVERAGE=true bundle install` followed by `COVERAGE=true bundle exec rake` to generate SimpleCov coverage in `coverage/`. GitHub Actions uploads the Ruby 4.0 job's report using the official Coveralls action.

Record user-visible changes in [CHANGELOG.md](CHANGELOG.md) under the next release, with an issue or pull request link when available and an author link. Danger checks changelog formatting on pull requests.

On MRI Ruby 3.3 or newer, `bundle exec rake lint` checks Ruby, Markdown, YAML, and spelling with the root Gemfile; add reviewed project vocabulary to `.spellcheck.txt`.
