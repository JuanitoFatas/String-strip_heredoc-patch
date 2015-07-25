require "benchmark/ips"
require_relative "./strip_heredoc"
require_relative "./patched_strip_heredoc"

def original
  <<-MSG.strip_heredoc
    xhr and xml_http_request methods are deprecated in favor of
    `get :index, xhr: true` and `post :create, xhr: true`
  MSG
end

def patched
  <<-MSG.patched_strip_heredoc
    xhr and xml_http_request methods are deprecated in favor of
    `get :index, xhr: true` and `post :create, xhr: true`
  MSG
end

Benchmark.ips do |x|
  x.report("original") { original }
  x.report(" patched") { patched  }
  x.compare!
end
