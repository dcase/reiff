class ContactListItem < ActiveRecord::Base
  belongs_to :contact_list
  
  acts_as_list :scope => :contact_list
  
  validates_presence_of :name, :email
  
  email_name_regex  = '[\w\.%\+\-]+'.freeze
  domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
  email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  bad_email_message = "should look like an email address.".freeze
  
  validates_format_of :email, :with => email_regex
end
