# Mongoid Revisions [![Build Status](https://secure.travis-ci.org/emilianodellacasa/mongoid_revisions.png)](https://secure.travis-ci.org/emilianodellacasa/mongoid_revisions.png)

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

### Added Attributes

- revision (read only)
- tag
- token (read only)

### Added Methods

- revisions
- tag_version
- revise
- branch

### Token Field

Token is a randomly generated string that is common to all revisions of the same document and it is write protected to preserve the functionality of this library. 

An index is automatically added to this field but to apply it you will have to issue the following command

 ```ruby
  rake db:mongoid:create_indexes
 ```

like all mongoid indexes.

### Create a new revision

Simply call the revise method

 ```ruby
	last_comment_revision = @comment.revise
 ```

Please note that the original object will be unchanged! 

### Create a new branch

To create a new branch of a given document, use

```ruby
  new_comment = @comment.branch
 ```

and the returned document will have a different token and will be at revision 0.

### Get all document's revisions

To access all revisions for a given document, use

 ```ruby
  @comment.revisions
 ```

### Tag a revision

Lastly, to modify a revision with a given tag, use

 ```ruby
  @comment.revise.tag_version("Beta stage")
 ```

to change the tag attribute of the document and save it in a single call.

### Access a document by a particular revision or tag

You can access a document by its revision or tag by using the following functions:

 ```ruby
  @comment.at_revision(2)
 ```

 ```ruby
  @comment.tagged("Beta stage")
 ```

### Navigate thru revisions

You can navigate thru all revisions of a document by using the 'next' and 'previous' functions:

 ```ruby
  @comment.next
 ```

 ```ruby
  @comment.previous
 ```

## Relations Gotcha

At present time, not all relation types supported by Mongoid get cloned by this gem. 

Here follow a list of all relation types with the indication in they are supported or not:

- has_one : SUPPORTED
- has_many : SUPPORTED
- belongs_to : UNSUPPORTED (Doesn't make any sense IMHO, but it will be possible to support it)
- has_and_belongs_to_many : SUPPORTED (only the relation between the two models gets cloned)
- embeds_many : UNSUPPORTED
- embeds_one : UNSUPPORTED

**Please note that starting from version 0.0.5 the revision process is recursive, so that if an associated object supports revision then it will undergo revision an so will be with all its associated objects, and so on.**

## Future changes (sort of TODO list)

- Add search method for tag
- Add support for cloning of "embeds_many" and "embeds_one" relations
- Add relation blacklist for all relations you don't want to clone

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/emilianodellacasa/mongoid_revisions/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Emiliano Della Casa and is under the MIT License and it is distributed by courtesy of [Engim srl](http://www.engim.eu/en).
