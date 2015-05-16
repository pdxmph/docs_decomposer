class Page < ActiveRecord::Base

  validates :filename, uniqueness: { scope: :version, message: "Filenames should only happen once per version." }
  serialize :frontmatter
  has_many :comments
  has_many :elements
  belongs_to :version
  belongs_to :user
  has_one :project, :through =>  :version
  accepts_nested_attributes_for :comments

  acts_as_votable
  acts_as_taggable
  acts_as_taggable_on :categories, :indexes
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :basename,
      [:project_name, :basename],
      [:project_name, :project_version, :basename]
    ]
  end

  def project_version
    self.version.version_number
  end
  
  def project_name
    self.project.name
  end
  
  def live_url
    html_name = filename.gsub(/(markdown|md)$/, "html")
    "https://#{self.version.preview_server}/#{self.project.name}/#{self.version.version_number}/#{html_name}"
  end

  def github_url
    repo = self.version.repo.name
    branch = self.version.branch
    return "https://github.com/puppetlabs/#{repo}/tree/#{branch}/source/#{filename}"
  end
  
  def commented?
    if comments.size > 0
      return true
    else
      return false
    end
  end

  def upvoted?
    if self.get_upvotes.size > 0
      return true
    else
      return false
    end
  end

  def upvoted_by_user?
    if current_user && current_user.voted_up_on?(self)
      return true
    else
      return false
    end
  end

  def upvoted_by_other?
    if self.upvoted? && self.upvoted_by_user? == false
      return true
    else
      return false
    end
  end

  def previous_page
     self.class.where("id < ? and version_id = ? ", id, version_id).order("id desc").first
  end

  def next_page
     self.class.where("id > ? and version_id = ?", id, version_id).order("id asc").first
  end

  def content_reimport
    file = File.read(self.app_file_location)
    begin
      src = file.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)
      markdown = src.post_match
      src_yaml =  YAML.load_file(self.app_file_location)
      self.title = src_yaml['title']
      self.subtitle = src_yaml['subtitle']
      self.frontmatter = src_yaml
      self.markdown_content = markdown
      self.generate_html
      self.repath_images
      self.save
      
     rescue Exception => e  
       puts "something went wrong getting HTML for #{self.title} -- #{e}"
    end
  end


  def element_purge
    elements = self.elements
    elements.delete_all
  end
  
  def element_import
    els = ["ol","pre","img"]
    html = Nokogiri::HTML(rendered_markdown_content)
    els.each do |e|
      html.xpath("//#{e}").each do |h|
        if e == "img"
          src_file = h['src']
          img_path =  "#{Rails.root}/repos#{src_file}"
          img = File.open(img_path)
          hash = Digest::MD5.hexdigest(Magick::Image.read(img).first.export_pixels.join)
        else
          hash = Digest::MD5.hexdigest(h.to_html)
        end
        element = Element.new
        element.page_id = self.id
        element.checksum = hash
        element.content = h.to_html
        element_head = h.xpath("preceding::*[name()='h1' or name()='h2' or name()='h3' or name()='h4' or name()='h5']")
      
        unless element_head.last.nil?
          element.nearest_heading = element_head.last.inner_text
        else
          element.nearest_heading = "#{self.title} (page title)"
        end

        element.filename = self.filename
        element.kind = e
        element.save
      end
    end
  end

  def repo_file_location
    "#{Rails.root}/repos/#{self.version.base_directory}#{filename}"
  end
  
  def app_file_location
    "#{self.version.repos_dir}#{filename}"
  end

  def file_exists
    File.exist?(app_file_location)
  end

  def recent_git(count=10)
    git = Git.open(self.repo.app_directory)
    page_log = git.gblob(app_file_location).log(count)
    return page_log
  end

  def basename
    File.basename(filename, File.extname(filename))
  end

  def local_path
    File.dirname(filename)
  end
  
  def public_path
   dir = File.dirname("#{self.version.version_directory}#{filename}")
    "/#{dir}"
  end
  
  def matching_files
    Page.where("filename LIKE ? AND id != ?", "%#{filename}", id)
  end

  def generate_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    html = markdown.render(self.markdown_content)
    self.rendered_markdown_content = html
  end

  
  def repath_images
    images_path = "#{public_path}"
    source = Nokogiri::HTML(rendered_markdown_content)
    source.xpath("//img").each do |i|
      if i[:src].match(/^\.\/images\//)
        i[:src] = i[:src].sub(/^\./,images_path)
      end
    end
    self.rendered_markdown_content = source
  end

end
