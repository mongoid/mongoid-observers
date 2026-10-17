### 0.4.1 (Next)

* Your contribution here.
* [#11](https://github.com/mongoid/mongoid-observers/pull/11): Add Appraisal-managed Rails integration tests for observer initialization, persisted callbacks and model reloading - [@dblock](https://github.com/dblock).

### 0.4.0 (2026/10/15)

* [#9](https://github.com/mongoid/mongoid-observers/pull/9): Add historical release notes and enforce changelog formatting with Danger - [@dblock](https://github.com/dblock).
* [#8](https://github.com/mongoid/mongoid-observers/pull/8): Fix observer delegation and global observer disabling on modern ActiveSupport, and explicitly load Logger - [@dblock](https://github.com/dblock).
* [#8](https://github.com/mongoid/mongoid-observers/pull/8): Test Ruby 2.7 through 4.0, Mongoid 4 through 9, Rails 4.2 through 8.1, and MongoDB 4.4 through 9.0 with GitHub Actions - [@dblock](https://github.com/dblock).
* [#8](https://github.com/mongoid/mongoid-observers/pull/8): Replace obsolete coverage integrations and badges with SimpleCov and the official Coveralls action, modernize generator specs, and restore the released rails-observers runtime dependency - [@dblock](https://github.com/dblock).

### 0.3.0 (2016/10/31)

* Support Mongoid 6 and Rails 5, including ActiveSupport::Reloader for observer reloading - [@chamnap](https://github.com/chamnap).
* [#2](https://github.com/mongoid/mongoid-observers/pull/2): Add Mongoid 6 tests and update the rails-observers development dependency for Rails 5 compatibility - [@phyllisstein](https://github.com/phyllisstein).
* Remove rails-observers from runtime dependencies and document installing its GitHub version for Rails 5 - [@chamnap](https://github.com/chamnap).

### 0.2.0 (2016/04/10)

* Support Mongoid 5 and test Mongoid 4 and 5 with separate dependency bundles - [@chamnap](https://github.com/chamnap).
* Require stable Mongoid 4.0 or newer instead of accepting the Mongoid 4 beta - [@chamnap](https://github.com/chamnap).
* Update the test suite to RSpec 3 and refresh development dependencies and Travis CI - [@chamnap](https://github.com/chamnap).

### 0.1.1 (2014/04/22)

* Relax the Mongoid dependency from the 4.0 beta series to Mongoid 4.0.0.beta1 or newer and correct the gem homepage - [@chamnap](https://github.com/chamnap).

### 0.1.0 (2014/04/20)

* Extract Mongoid::Observer from Mongoid for applications using Mongoid 4, including lifecycle and custom callbacks, observer configuration, and selective observer disabling - [@chamnap](https://github.com/chamnap).
* Add Rails initialization and reloading integration and an observer generator with namespace support - [@chamnap](https://github.com/chamnap).
* Add observer and generator specs, Travis CI, and coverage reporting - [@chamnap](https://github.com/chamnap).
