class Page < ActiveRecord::Base

  validates :filename, uniqueness: { scope: :version, message: "Filenames should only happen once per version." }
  serialize :frontmatter
  has_many :comments
  has_many :elements
  belongs_to :version
  belongs_to :user
  has_one :project, :through =>  :version
  accepts_nested_attributes_for :comments

  before_save :make_url
  
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

  scope :active, -> {joins(:version).where('versions.active = ?', true)}
  scope :inactive, -> {joins(:version).where('versions.active = ?', false)}
  scope :missing, Proc.new { |page| page.file_exists == false}

  
  def project_version
    self.version.version_number
  end
  
  def project_name
    self.project.name
  end
  
  def make_url
    html_name = filename.gsub(/\.(markdown|md)$/, ".html")
    base_url = self.project.web_path

    if  /^\/source\//.match(html_name)
      html_name.gsub!(/^\/source/, "")
    end
  
    if self.project.versioned?
      url =  "#{base_url}/#{self.version.version_number}#{html_name}"
    else
      url =  "#{base_url}#{html_name}"
    end

    self.live_url = url
    
  end

  
  def github_url
    branch = self.version.branch
    repo_url = self.version.source_repo

    if self.project.display_name == "Guides"
      return "#{repo_url}/tree/#{branch}/source/#{version.project.name}#{filename}"
    elsif self.version.source_repo.include?("puppet-docs")
      return "#{repo_url}/tree/#{branch}/source/#{version.project.name}/#{version.version_number}#{filename}"
    else
      return "#{repo_url}/tree/#{branch}#{filename}"
    end
	    
  end
  
  def commented?
    comments.size > 0 ? true : false
  end

  def upvoted?
    self.get_upvotes.size > 0 ? true : false
  end

  def upvoted_by_user?
    current_user && current_user.voted_up_on?(self) ? true : false
  end

  def upvoted_by_other?
    self.upvoted? && self.upvoted_by_user? == false ? true : false
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
          hash = Digest::MD5.file(img_path).hexdigest
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
    begin
      git = Git.open("#{Rails.root}/repos/#{self.version.repo_base}")
      page_log = git.gblob(app_file_location).log(count)
      return page_log
    rescue Git::GitExecuteError
      return "Error getting git log"
    end
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
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true, fenced_code_blocks: true)
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

  def has_owner
    self.user_id.nil? ? false : true
  end

  def self.missing_files
    pages = Page.active.select { |page| page.file_exists == false }
    return pages
  end
end
