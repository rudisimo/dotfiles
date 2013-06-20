# dotfiles

## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. The `bootstrap.sh` script will pull in the latest version and copy the files to your home folder.
```bash
git clone https://github.com/rudisimo/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:
```bash
source bootstrap.sh -u
```

Alternatively, to update while avoiding the confirmation prompt:
```bash
source bootstrap.sh -uf
```

### Without using Git

To install these dotfiles without Git:
```bash
cd ~; curl -#L https://github.com/rudisimo/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,LICENSE-MIT.txt,bootstrap.sh};
```

**WARNING**: This may overwrite all of your existing dotfiles.

To update later on, just run that command again.

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.
Here's an example:

```bash
# EC2 settings
export EC2_HOME=~/.ec2
export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
export EC2_CERT=`ls $EC2_HOME/cert-*.pem`

# Android settings
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk

# EC2 binaries
PATH=$PATH:$EC2_HOME/bin

# Android binaries
PATH=$PATH:$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools
```

You could also use `~/.extra` to change settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/rudisimo/dotfiles/fork) instead, though.

## Feedback

Bugs and feature request are tracked on [GitHub](https://github.com/rudisimo/dotfiles/issues)!

## Author

Rodolfo Puig [@rudisimo](http://twitter.com/rudisimo "Follow @rudisimo on Twitter")

## License

This package is licensed under the MIT License - see the LICENSE-MIT.txt file for details.

## Acknowledgements

* [Mathias Bynens](http://mathiasbynens.be/) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
