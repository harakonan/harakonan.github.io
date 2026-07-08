# harakonan.github.io

Personal website built with GitHub Pages and Jekyll.

## Local setup

Use a user-managed Ruby instead of macOS system Ruby. With Homebrew, install `rbenv` once:

```sh
brew install rbenv ruby-build
```

Add rbenv to your shell if it is not already configured:

```sh
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc
```

Then install the repo Ruby and dependencies:

```sh
rbenv install
gem install bundler -v 2.4.21
bundle install
```

Run the site locally:

```sh
bundle exec jekyll serve
```

Bundler should resolve from the rbenv Ruby, not from `/usr/bin/bundle`.
