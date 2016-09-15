### Overview

[![Build Status](https://travis-ci.org/rambler-ios/Generamba.svg)](https://travis-ci.org/rambler-ios/Generamba)
[![Gem Version](https://badge.fury.io/rb/generamba.svg)](https://badge.fury.io/rb/generamba)
[![Code Climate](https://codeclimate.com/github/rambler-ios/Generamba/badges/gpa.svg)](https://codeclimate.com/github/rambler-ios/Generamba)

**Generamba** is a code generator made for working with Xcode. Primarily it is designed to generate VIPER modules but it is quite easy to customize it for generation of any other classes (both in Objective-C and Swift).

*We keep evolving Generamba:* [changelog](https://github.com/rambler-ios/Generamba/blob/develop/CHANGELOG.md), [release notes](https://github.com/rambler-ios/Generamba/releases).

![Generamba Screenshot](https://habrastorage.org/files/b98/770/b37/b98770b37dc54de98daf0e22fea38478.gif)


### Key features

- Supports work with *.xcodeproj* files out of the box. All generated class files are automaticly placed on specific folders and groups of Xcode project.
- Can generate both code itself and tests adding them to right targets.
- Based on work with [liquid-templates](https://github.com/Shopify/liquid) that have plain and readable syntax in comparison with templates for Xcode.
- It is very easy to create a new module: `generamba gen [MODULE_NAME] [TEMPLATE_NAME]`. You do not need to input a bunch of data each time because each project corresponds to only one configuration file that holds standard file system and Xcode-project pathes, names of targets, information about the author.

### Installation

> Ruby 2.2 or later version is required. To check your current Ruby version run this command in terminal:
```bash
$ ruby --version
```
When necessary you can install the required Ruby version with the help of [`rvm`](http://octopress.org/docs/setup/rvm/) or [`rbenv`](http://octopress.org/docs/setup/rbenv/).

Run the command `gem install generamba`.

Buil generamba

```bash
$ gem build generamba.gemspec && gem install --local generamba-1.2.1.gem
```


### Usage
1. Run [`generamba setup`](https://github.com/rambler-ios/Generamba/wiki/Available-Commands#basic-generamba-configuration) in the project root folder. This command helps to create [Rambafile](https://github.com/rambler-ios/Generamba/wiki/Rambafile-Structure) that define all configuration needed to generate code. You can modify this file directly in future.
2. Add all templates planned to use in the project to the generated [Rambafile](https://github.com/rambler-ios/Generamba/wiki/Rambafile-Structure). You can begin with one of the templates from our catalog: `{name: 'rviper_controller'}`.
3. Run [`generamba template install`](https://github.com/rambler-ios/Generamba/wiki/Available-Commands#template-installation). All the templates will be placed in the '/Templates' folder of your current project.
4. Run [`generamba gen [MODULE_NAME] [TEMPLATE_NAME]`](https://github.com/rambler-ios/Generamba/wiki/Available-Commands#module-generation) - It creates module with specific name from specific template.

### Additional info

Run `generamba help` to learn more about each of the Generamba features.

**Wiki:**
- [Command list](https://github.com/rambler-ios/Generamba/wiki/Available-Commands)
- [Understanding the Rambafile](https://github.com/rambler-ios/Generamba/wiki/Rambafile-Structure)
- [Understanding templates](https://github.com/rambler-ios/Generamba/wiki/Template-Structure)

**Other materials:**
- [Russian] Rambler.iOS V: Generamba and Code Generation ([Slides](http://www.slideshare.net/Rambler-iOS/viper-56423582) | [Video](http://www.youtube.com/watch?v=NXNiN9FaUnY))
- [Introduction to Generamba](http://etolstoy.com/2016/02/10/generamba/)

### Authors

- Egor Tolstoy, Beniamin Sarkisyan, Andrey Zarembo and the rest of [Rambler.iOS team](https://github.com/orgs/rambler-ios/people).

### License

MIT
