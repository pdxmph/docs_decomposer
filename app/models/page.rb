class Page < ActiveRecord::Base

  acts_as_votable
  acts_as_taggable
  acts_as_taggable_on :categories, :indexes

  extend FriendlyId
  friendly_id :title, use: :slugged
  def slug_candidates
    [
      :title,
      [:title, :id]
    ]

  end
  has_many :comments
  has_many :elements
  belongs_to :version
  has_one :project, :through =>  :version
  
  accepts_nested_attributes_for :comments

  def live_url
    html_name = filename.gsub(/(markdown|md)$/, "html")
    "https://docs.puppetlabs.com/#{html_name}"
  end
  
  
  def previous_page
     self.class.where("id < ? and version_id = ? ", id, version_id).order("id desc").first
  end

  def next_page
     self.class.where("id > ? and version_id = ?", id, version_id).order("id asc").first
  end

  def remote_content
    require 'open-uri'
    doc = Nokogiri::HTML(open(url))
    doc_content = doc.xpath("//div[@id='rendered-markdown']")
    return doc_content.inner_html
  end

  def github_url
    return "https://github.com/puppetlabs/puppet-docs/tree/master/source#{filename}"
  end

  def content_reimport
    images_path = self.filename.gsub(/(^.*\/)\w{1,}\.(md|markdown)/, "/puppet-docs/source/\\1")
    require 'open-uri'
    begin
       doc = Nokogiri::HTML(open(self.live_url))
       doc_content = doc.xpath("//div[@id='rendered-markdown']")

       doc_content.xpath("//img").each do |i|
         if i[:src].match(/^\.\/images\//)
           i[:src] =  i[:src].gsub(/^\.\/images\//, "#{images_path}images/")
         end
       end

       self.content = doc_content.inner_html
       self.save
   
     rescue Exception => e  
       puts "something went wrong getting HTML for #{self.title} -- #{e}"
    end
    
  end
      
end

