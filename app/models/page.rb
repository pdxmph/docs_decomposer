class Page < ActiveRecord::Base

  validates_uniqueness_of :filename

  acts_as_votable
  acts_as_taggable
  acts_as_taggable_on :categories
  has_many :comments
  has_many :elements
  accepts_nested_attributes_for :comments


    
  def previous_page
    self.class.where("id < ?", id).order("id desc").first
  end

  def next_page
    self.class.where("id > ?", id).order("id asc").first
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
  
end

