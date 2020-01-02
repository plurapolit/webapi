# PluraPolit Web API

## Solargraph Setup (for VSCode)
1. Install "Ruby" and "Ruby Solargraph" VSCode extensions
2. Add `gem 'solargraph', group: :development` to the Gemfile
3. Run `bundle install`
4. Run `solargraph config`
5. Change `require: []` to the following in `solargraph.yml`
```
require:
- actioncable
- actionmailer
- actionpack
- actionview
- activejob
- activemodel
- activerecord
- activestorage
- activesupport
```

6. run `solargraph bundle`

## Before Pushing to GitHub
1. Have you written tests for the new feature?
2. Run `rspec` --> All tests should pass
3. Run `rubocop` --> There should be no offenses
4. Run `rails_best_practices` --> There should be no offenses
5. Run `brakeman` --> There should be no offenses