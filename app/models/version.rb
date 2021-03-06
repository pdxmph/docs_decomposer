class Version < ActiveRecord::Base
  validates :version_number, :version_directory, :branch, :presence => true
  
  belongs_to :project
  validates :project_id, :presence => true
  

  has_many :pages, :dependent => :destroy  
  has_many :comments, :through => :page

  scope :published, -> {where(:published => true)}
  
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  
  def slug_candidates
    [
      :version_number,
      [:project_name, :version_number]
    ]
  end


  def project_name
    self.project.name
  end
  
  def high_risk_pages
    self.pages.where(:risk => 3).count
  end

  def high_priority_pages
    self.pages.where(:priority => 3).count
  end

  scope :active, -> {where(:active => true)}
  scope :inactive, -> {where(:active => false)}

  def repo_base
    self.base_directory.sub(/\/.*/, "")
  end
  
   def base_directory
     "#{self.version_directory}/"
   end

  def repos_dir
    "#{Rails.root}/repos/#{self.version_directory}"
  end
   
  def public_dir
    "#{Rails.root}/public/#{self.version_directory}"
  end

  def import_files
    require 'find'
    
    Dir.chdir(self.repos_dir) do
      system("git checkout #{branch} --quiet && git pull --ff --quiet && git clean --force . --quiet")
    end
    
    Find.find(self.repos_dir) do |f|
        next unless f.match(/\.(markdown|md)\Z/)
        next if f.match(/.+?\/_(.+?)\.(markdown|md)/)
        file = File.read(f)
        begin
         src = file.match(/^(---\s*\n.*?\n?)^(---\s*$\n?)/m)
         markdown = src.post_match
         src_yaml =  YAML.load_file(f)
        rescue Exception => e
          puts e
          next
        end

       file_name = f.gsub(/#{repos_dir}/, "")

        begin
          page =  self.pages.find_or_initialize_by(:filename => file_name)
          page.title = src_yaml['title']
          page.subtitle = src_yaml['subtitle']
          page.frontmatter = src_yaml
          page.markdown_content = markdown
          page.generate_html
          page.repath_images
          page.save
          
        rescue Exception => e  
          puts "Problem with this file: #{f}\n#{e}"
          next
        end
    end
  end


  
end


