# Docs Decomposer

The Docs Decomposer is an inventory tool for documentation at Puppet
Labs. With it, you can:

- Import the pages and content from a given Puppet Labs project or
upstream.
- Flag, comment on, tag, and assign risk/priority to each page
- Review each page with the option to quickly reveal only: 
  - Heading structure (h-tags)
  - Code and command line examples/steps (pre/code elements)
  - Procedures (ordered, unordered lists)
  - Screenshots (images)

It supports multiple users, each of which can leave comments or set
flags under their own identity. Users designated as an "admin" can set
the risk or priority of a page and also add/remove tags.

## Setup

The tool has a few rake tasks to help with setup once the app is
cloned and you've run `rake db:migrate`. 

    rake setup:update_puppetdocs                           # Update the local puppetdocs repo
    rake setup:import_files                                # Import files from the local puppetdocs repo
	rake setup:import_html                                 # Import HTML for pages
    rake setup:import_elements                             # Import elements from page HTML
    rake setup:set_admins                                  # Make the tech writers admins

## Use

### Flagging

Flagging a page just means that the current user has marked it

### Risk

Admin users can set the risk of a page: High, Medium, Low

* Low: "This page is mostly harmless. If there's an error, it will
eventually irritate someone, but it won't hurt them."

* Medium: "This page has some content that will cause the user
problems, but will not affect their ability to talk to their
infrastructure with PE."

* High: "This page has content that could cause the user to be unable
to use PE to manage their infrastructure."

Page risk can be set on individual pages, or on index pages for each
version of a project.

### Priority

Admin users can set the priority of a page: High, Medium, Low. 

Priority can be set on individual pages.

### Tagging

Admin users can set and delete tags. When entering tags in the tag
modal, use comma-delimited lists for multiple tags. 

Tags are free-form. Some good conventions:

- all lower case
- underscores replace spaces
- singular instead of plural
- no punctuation

Tags can be set on individual pages. 

### Comments

You can use light Markdown to comment. You can edit and delete your own comments.




