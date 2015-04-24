# TODOs

- [ ] Tags for individual pages should be settable at the pages view
- [ ] Pages should be categorized at least broadly (look for repeating titles)
- [ ] Links to real docs pages broken
- [ ] puppet-docs repo refresh should be clickable by admin
- [ ] admin flag should be settable from user edit view
- [ ] Devise should talk to LDAP
- [ ] Improve HTML/Element import
  - [ ] Elements should be blown out when created for a page
  - [ ] Element creation should be intrinsic to HTML import for a page
  - [ ] HTML import should be intrinsic to creation of a page
- [ ] Application understands "Current Version" 
  - [ ] Affects default pages shown on user page tab
  - [ ] Pauses HTML update on previous versions (manual will still work)
- [ ] Page inventory reflects reality (Missing pages marked "deleted" or otherwise downgraded)
- [ ] Page metadata includes source repo and branch for e-z GitHub linking
- [ ] dev branch update can be suspended when not actively tracking docs dev work

# Future

# Wishlist

- [ ] @name users in comments, mail notifications

# Done
- [x] Importer should understand `puppetdocs` and `puppetdocs-private` repos.
- [x] App should understand an internal preview server for `puppetdocs-private`
- [x] table rows should get ids, table data should come from partial for update of risk button
- [x] User name not being saved by signup (fixed)
- [x] Tags are overwritten by form (need to add, not overwrite) (Fixed)
- [x] Use [@page.tags.any?](http://alexmuraro.me/posts/acts-as-taggable-on-a-short-tutorial/)
- [x] Comments are not editable
- [x] "Pages you've flagged" should just use the standard pages table
- [x] Risk should be settable at the pages view
- [x] User edit page should be bootstrapified, include access to user name
- [x] Have to reload to refresh risk status on pages view
