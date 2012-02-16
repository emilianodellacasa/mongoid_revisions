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

Token is a randomly generated string that is common to all revisions of the same document and it is wirte protected to preserve the functionality of this library. 
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

To access all revisitons for a givent document, use

 ```ruby
  @comment.revisions
 ```

### Tag a revision

Lastly, to modify a revision with a given tag, use

 ```ruby
  @comment.revise.tag_version("Beta stage")
 ```

to change the tag attribute of the document and save it in a single call.

## Future changes (sort of TODO list)

- Check if linked relations cloning work for all relation's tipologies
- Recursive revision to linked documents
- Add methods to access a particular revision or tag
- Add search method for revision and tag

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/emilianodellacasa/mongoid_revisions/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by Emiliano Della Casa and is under the MIT License and it is distributed by courtesy of [Engim srl](http://www.engim.eu/en).
