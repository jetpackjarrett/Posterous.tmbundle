Posterous Textmate Bundle
---------

A Textmate bundle that allows users to create and update to the Posterous blog directly from Textmate. It uses the Posterous REST API.  For more information see: [http://apidocs.posterous.com/](http://apidocs.posterous.com/). 

## Installation

Install the bundle by checking out the git repo to your Bundles directory:

    $ git clone git@github.com:jarrettgossett/Posterous.tmbundle.git ~/Library/Application\ Support\Textmate/Bundles/

Or you can download/checkout the repo and double-click on the tmbundle file which should load it as a bundle in Textmate automatically.


## Setup

The bundle relies on a file created in your home directory,  ~/.posterous

Create the file and in it put:

    username: your_posterous_login@example.com
    password: your_posterous_password
    api_token: your_api_token (Avialable at: ???????)
    site: a_site_id (Optional, leave blank if you only want to use a site other than your primary site)
    
## Usage

### Posting a document

To create a post from a document, simply open a document and execute the key command (defaults to ⌘⇧P) and it will automatically send the post. Please note the document must be saved before it can be posted.

### Posting a selection

If you wish to post a selection, simply execute the key combination  ⌘⇧P with a portion of code selected.

### Adding metadata/options

Adding colon separated values to the top of a document and the bundle will treat them as options for your blog post.

    ID: id_of_post (Only if it is an existing post)
    TITLE: The title of the post
    TAGS: some, example, tags, comma, delimited
    DISPLAY_DATE: 01/01/69

The tab trigger "pmeta" will automatically insert all available options.

### Getting a post

To pull down an already created post:

* Create a new Textmate document.
* Paste in the post's id and highlight it
* Press ⌘⌥⇧P

### Updating a post

Any post submitted with an ID option will be updated rather than created.

## Credits

Jarrett Gossett - jarrettgossett@gmail.com | [github.com/jarrettgossett ](github.com/jarrettgossett)

Based on Chris Burnett's Postly bundle: [http://github.com/twoism/postly](http://github.com/twoism/postly).

