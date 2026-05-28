# curriculum vitae

* Based on [moonwalk](https://github.com/abhinavs/moonwalk) by Abhinav Saxena.
* Modified to fit my needs and embellished.


## Local Development (macOS)

To run this Jekyll site locally with the correct Ruby and Bundler versions:

1. **Install Ruby version manager (rbenv):**
	```sh
	brew install rbenv ruby-build
	echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
	source ~/.zshrc
	```

2. **Install the required Ruby version:**
	```sh
	rbenv install 3.2.9
	rbenv local 3.2.9
	```

3. **Install Bundler (matching Gemfile.lock):**
	```sh
	gem install bundler -v 2.7.2
	```

4. **Install dependencies:**
	```sh
	bundle _2.7.2_ install
	```

5. **Run the local server:**
	```sh
	bundle exec jekyll serve
	```

6. Open http://127.0.0.1:4000 in your browser.

**Note:** Never use the system Ruby for development. Always use a user-managed Ruby (via rbenv, asdf, or mise).

## To use:

* Update the `.md` files and do a `git push`
* To test you can run `bundle exec jekyll serve`
* Note that blog posts live under `_posts` and that they have a naming convention which will be parsed on the website
