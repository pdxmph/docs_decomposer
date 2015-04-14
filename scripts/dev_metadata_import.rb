# Use this to migrate metadata from one version of a project to another
# This is generally to prime a new version with existing priority and risk
# information. 

project_name = "pe"
live = "3.7"
dev = "3.8-dev"

project = Project.find_by_name(project_name)
live_version = project.versions.find_by_version_number(live)
dev_version = project.versions.find_by_version_number(dev)

live_version.pages.each do |page|
  begin 
    private_page = dev_version.pages.find_by_filename(page.filename)
    private_page.risk = page.risk
    private_page.priority = page.priority
    private_page.tag_list.add(page.tag_list)
    private_page.save
  rescue Exception => e
    puts e
  end

  if page.comments.size > 0
    page.comments.each do |old_comment|
      new_comment = old_comment.clone
      new_comment.page_id = private_page.id
      new_comment.save
    end
  end
end
