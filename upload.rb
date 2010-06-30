require 'rubygems'
require 'sinatra'
require 'uri'
require 'haml'

before do
  content_type "text/html", :charset => "utf-8"
end

get '/' do
  'what?'
end

get '/upload' do
  haml :upload
end

get '/list' do
  @list = %x{ ls #{@@root_dir}/public/ }
  haml :list
end

post '/upload' do
  unless params[:f] and (tmpfile = params[:f][:tempfile]) and (name = params[:f][:filename])
    return haml(:upload)
  end
  
  tofile = "#{@@root_dir}/public/#{name}"
  File.open(tofile.untaint, 'w') { |file| file << tmpfile.read } 
  "http://#{@@server}/#{@@virtual_dir}/#{URI.encode(name)}"
end

def title(title=nil)
  @title = title.to_s unless title.nil?
  @title
end

__END__
@@ layout
!!!
%html
  %head
    %title= title
  %body
    #content= yield

@@ upload
- title "Upload something awesome"
%h1= title
%form{:action=>"/#{@@virtual_dir}/upload",:method=>"post",:enctype=>"multipart/form-data"}
  %p
    %input{ :type => :file, :name => 'f' }
  %p
    %input{ :type => :submit, :value => 'go' }

@@ list
%ul#list
  - @list.each do |file|
    %li
      %a{ :href=> "/#{@@virtual_dir}/#{ URI.encode( file.strip ) }"}= file
