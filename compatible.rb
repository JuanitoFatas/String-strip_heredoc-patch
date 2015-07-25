require_relative "./strip_heredoc"
require_relative "./patched_strip_heredoc"

original = <<-MSG.strip_heredoc
             xhr and xml_http_request methods are deprecated in favor of
             `get :index, xhr: true` and `post :create, xhr: true`
           MSG

 patched = <<-MSG.strip_heredoc
             xhr and xml_http_request methods are deprecated in favor of
             `get :index, xhr: true` and `post :create, xhr: true`
           MSG

if original == patched
  puts "yea"
else
  fail "Arrrrgh"
end
