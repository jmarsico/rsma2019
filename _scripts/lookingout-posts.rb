require 'slack-ruby-client'
require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'json'
#require 'xmlsimple'
require 'oembed'
require "embedly"
require 'axlsx'
require 'sanitize'

EMBEDLY_KEY = "833902d4a1514eaeae23ed3fe486e842"
EMBEDLY_APP = "Feed Tengu"
EMBEDLY_EMAIL = "subscriptions@xsead.org"  

ENV['SLACK_API_TOKEN'] = "xoxp-126335398929-127013901154-132571075031-7a382bf05059275c70c6d1f4e541ee41"
ENV['LOOKING_OUT_TAG'] ||= "#producthunt"
ENV['SLACK_CHANNEL'] ||= "discoveries"


OEmbed::Providers.register_all

def truncate(string, max)
  string.length > max ? "#{string[0...max]}..." : string
end


def convert_to_html
  file = File.read( ENV['LOOKING_OUT_TAG'] + '.json')
  looking_outs = JSON.parse(file)

    #print looking_outs.to_yaml( :indent => 4 )

  html_string = ""

  html_string += "<div class=\"isotope-filters\">"

  html_string += "<div id=\"filters\" class=\"isotope-button-group\">"
  html_string += "<h2>Filter By User:</h2>"
  html_string += "<button class=\"button is-checked\" data-filter=\"*\">Show all</button>"

  posts_by_user = looking_outs.group_by{ |d| d["user_id"] }

  posts_by_user.each do |user_id, posts_array| 
    html_string += "<button class=\"button\" data-filter=\".#{ user_id }\">#{ posts_array.first["user_name"] } <span class='count'>#{posts_array.count}</span></button>"
  end
  #   <button class="button" data-filter=".metal">metal</button>
  html_string += "</div>"

  html_string += "<div id=\"sorts\" class=\"isotope-button-group\">"
  html_string += "<h2>Sort:</h2>"
  html_string += "<button class=\"button is-checked\" data-sort-by=\"original-order\">Original Order</button>"
  html_string += "<button class=\"button\" data-sort-by=\"category\">Username</button>"
  html_string += "<button class=\"button\" data-sort-by=\"title\">Title</button>"
  html_string += "<button class=\"button\" data-sort-by=\"timestamp\">Time Posted</button>"
  html_string += "</div>"

  html_string += "</div>"


  html_string += "<div class=\"isotope-grid\">"

  # elements
  looking_outs.each do |post|

    html_string += "<div class=\"isotope-element-item #{ post["user_id"] } \" data-category=\"#{ post["user_id"] }\">"
  
    doc = Nokogiri::HTML( post["html"] )
    img_srcs = doc.css('img').map{ |i| i['src'] } 
    if img_srcs.count > 0
      html_string += "<div class=\"cover-img\">"
      html_string += "<div class=\"image\" src=\"#{ img_srcs.first }\" style=\"background-image: url( #{ img_srcs.first }) !important;\"  ></div>"
      html_string += "</div>"
    end
  
    html_string += "<h3 class=\"title\"><a target=\"_blank\" href=\"#{ post["url"] }\" class=\"read-more\">#{ post["title"].gsub!(/\B[@#]\S+\b/, '') }</a></h3>"
    html_string += "<p class=\"username\">Shared by <a target=\"_blank\" href=\"https://mediasynth2016.slack.com/messages/lookingout/team/#{post["user_name"].gsub('@','')}\">#{post["user_name"]}</a></p>"
    html_string += "<p class=\"timestamp\">#{ post["timestamp"] }</p>"
  
    cleaned = Sanitize.fragment( post["html"] )
    description = truncate( cleaned, 150 )
  
    html_string += "<p class=\"description\">#{ description }... <a target=\"_blank\" href=\"#{ post["url"] }\" class=\"read-more\">Read more</a></p>"
    html_string += "</div>"
  
  end 

  html_string += "</div>"

  #print html_string


  File.open( ENV['LOOKING_OUT_TAG'] + ".html", 'w') { |file| file.write( html_string ) }
end 

def format_slack_json_as_html json
  
  html_string = ""
  
  json["root"]["children"].each do |item|
    item_type = item["type"]
    
    if item_type != "unfurl"
      item_text = item["text"]
      html_string = html_string + "<#{item_type}>" + item_text + "</#{item_type}>"
      
    else
      item_url = item["url"]
      html_string += unfurl( item_url )
    end
  end
  
  return html_string
end

# https://api.slack.com/docs/message-attachments#unfurling
def unfurl url
  
  img_extensions = %w[.jpg .jpeg .png]
  return "<img src='#{ url }' />" if img_extensions.any?{ |ext| url.end_with?(ext) }
  
  begin 
    resource = OEmbed::Providers.get( url ) #=> OEmbed::Response
  
    #resource.type #=> "video"
    #resource.provider.name #=> "Youtube"
    if not resource.nil?
      return resource.html
    end
  rescue
    return "<img src='#{ url }' />" 
  end
  
  return ""
end


OEmbed::Providers.register_all
# since register_all does not register all default providers, we need to do this here. See https://github.com/judofyr/ruby-oembed/issues/18
#OEmbed::Providers.register(::OEmbed::Providers::Instagram, ::OEmbed::Providers::Slideshare, ::OEmbed::Providers::Yfrog, ::OEmbed::Providers::MlgTv)
#OEmbed::Providers.register_fallback(::OEmbed::ProviderDiscovery, ::OEmbed::Providers::Embedly, ::OEmbed::Providers::OohEmbed)

noembed = OEmbed::Provider.new("https://noembed.com/embed")
noembed_providers = JSON.parse(Net::HTTP.get(URI.parse("https://noembed.com/providers")))
noembed_providers.map{ |p| p['patterns'] }.flatten.map{ |url| noembed << Regexp.new(url) }
OEmbed::Providers.register(noembed)
OEmbed::Providers.register_fallback(noembed)

slack_client_id = "68732251061.74971557189"
slack_client_secret = "be7db06442c794aa9654af643e4e0e69"

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  #config.user_agent = 'Slack Ruby Client/1.0'
end


client = Slack::Web::Client.new
client.auth_test

channels = client.channels_list.channels

lookingout_channel = channels.detect { |c| c.name == ENV['SLACK_CHANNEL'] }

channel_id = lookingout_channel[:id]

history = client.channels_history( channel: channel_id, count: 1000  )

#puts history.messages.to_yaml( :Indent => 4, :UseHeader => true, :UseVersion => true )

posts_data = []
count = 0

for item in history.messages do
  
  if item.type == "message" and item.subtype == "file_share" and defined? item.file and item.file.pretty_type == "Post"
    #puts "\n\n\n We have a post "
    
    post = item.file
    title = post.title
    timestamp = post.timestamp
    user = post.user
    
    if title.downcase.include? ENV['LOOKING_OUT_TAG'].downcase
      count += 1 
      puts "Matching Looking out: found #{count} "
      #puts post.to_yaml( :Indent => 4 ) 
      
      # get the user info 
      
      user_info = client.users_info( user: user  )
      #puts user_info.user( :Indent => 4 ) 
      
      user_handle = "@" + user_info.user.name.to_s
      real_name = user_info.user.profile.real_name_normalized.to_s
      email_address = user_info.user.profile.email.to_s
      andrew_id = user_info.user.profile.email.to_s[ /[^@]+/ ]

      
      # ak can't use this as it's not publicly assessible unless shared! 
      rendered_content_url = post.permalink
      #page = Nokogiri::HTML(open( rendered_content_url, 'Authorization' => 'Bearer ' + ENV['SLACK_API_TOKEN'] ))   
      #html_content = page.css('div.content')
      #puts page

      # get the content from the url_private_download
      raw_content_url = post.url_private
      content_json = open( raw_content_url, 'Authorization' => 'Bearer ' + ENV['SLACK_API_TOKEN'] ).read
      content_obj = JSON.parse( content_json )
      #puts content_obj.to_yaml( :Indent => 4 ) 
      
      #add formatting (tabs, b, i later)
      
      html_formatted = format_slack_json_as_html content_obj
      #puts html_formatted
      
      posts_data << { user_id: user, user_name: user_handle, real_name: real_name, email_address: email_address, andrew_id: andrew_id, title: title, timestamp: timestamp, url: rendered_content_url, html: html_formatted }
      
    end
    
  end
  
end

File.open( ENV['LOOKING_OUT_TAG'] + ".json","w") do |f|
  f.write(posts_data.to_json)
end

posts_by_user = posts_data.group_by { |d| d[:user_id] }

p = Axlsx::Package.new 
sheet = p.workbook.add_worksheet(:name => ENV['LOOKING_OUT_TAG'] )
sheet.add_row ["Slack Username", "Real Name", "Email",  "Andrew ID", "Post Count", "Post URL", "Complete", "Second Post URL", "Complete", "Third Post URL", "Complete" ]

posts_by_user.each do |user_id, posts_array|
 
  first = posts_array.first 
  user_row = [ first[:user_name], first[:real_name], first[:email_address], first[:andrew_id], posts_array.count ]
  
  posts_array.each do |post|
    user_row << post[:url] + ""
    user_row << "1"
  end

  sheet.add_row user_row
  
end


p.serialize(ENV['LOOKING_OUT_TAG'] + '.xlsx')

convert_to_html



# CALL AS FOLLOWS

#LOOKING_OUT_TAG='#lookingout2b' ruby lookingout-posts.rb 
#LOOKING_OUT_TAG='#lookingout2a' ruby lookingout-posts.rb 
#LOOKING_OUT_TAG='#criticalissue' ruby lookingout-posts.rb 

