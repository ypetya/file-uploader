To run with passenger, create a ''config.ru'' something like this:

<pre>
#!/usr/bin/env rackup
require 'upload'
require 'rubygems'
require 'sinatra'

@@root_dir = File.dirname(__FILE__)
@@virtual_dir = 'awesome_secret_files_app'
@@server = 'xx.xx.xx.xx'

set :env, :production
set :root,        @@root_dir
set :app_file,    File.join(@@root_dir, 'upload.rb')
set :haml, { :format => :html5, :attr_wrapper => '"' }

use_in_file_templates!

disable :run

run Sinatra::Application
</pre>

And create directories ''config, log, public, tmp''
