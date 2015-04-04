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





