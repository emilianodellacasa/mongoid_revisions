# Mongoid Revisions

Add support for revisions to your Mongoid documents

## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem "mongoid_revisions"
 ```

**Requires Ruby 1.9.2 or later and Mongoid 2.4.2 or later.**

## Usage

To add support for revisions to a Mongoid documents, include the module to your Model:

 ```ruby
 class Comment
   include Mongoid::Document
   include Mongoid::Revisions
 end
 ```

This gem adds to your Mongoid document the following attributes:

- revision
- tag

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/emilianodellacasa/mongoid_revisions/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Emiliano Della Casa and is under the MIT License.
