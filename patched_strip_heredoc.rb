require "active_support/core_ext/object/try"
require "get_process_mem"

class String
  def patched_strip_heredoc
    gsub(/^#{scan(/^[ \t]*(?=\S)/).min}/, "".freeze)
  end
end

if ENV["MEASURE_MEMORY"] == "yes"
  mem = GetProcessMem.new
  GC.start
  GC.disable
  10000.times do
    <<-MSG.patched_strip_heredoc
      xhr and xml_http_request methods are deprecated in favor of
      `get :index, xhr: true` and `post :create, xhr: true`
    MSG
  end
  before = mem.mb

  after = mem.mb
  GC.enable
  puts "Before: #{before} MiB"
  puts "After: #{after} MiB"
  puts "Diff: #{after - before} MiB"
end
