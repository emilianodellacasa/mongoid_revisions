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

- revision (read only)
- tag
- token (read only)

and the following methods:

- revisions
- tag_version
- revise

Token is a randomly generated string that is common to all revisions of the same document and it is wirte protected to preserve the functionality of this library.

Simply call the revise method

 ```ruby
	last_comment_revision=@comment.revise
 ```

to create a new revision for a document. Please note that the original object will be unchanged!

To access all revisitons for a givent document, use

 ```ruby
  @comment.revisions
 ```

Lastly, to modify a revision with a given tag, use

 ```ruby
  @comment.revise.tag_version("Beta stage")
 ```

to change the tag attribute of the document and save it in a single call.

## Future changes (sort of TODO list)

- Recursive revision to linked documents
- Branching to create a new document at revision a 0 and with a token different from the original

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/emilianodellacasa/mongoid_revisions/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Emiliano Della Casa and is under the MIT License and it is distributed by courtesy of [Engim srl](http://www.engim.eu/en).
