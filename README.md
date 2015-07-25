## Implementation Diff

```diff
diff --git a/activesupport/lib/active_support/core_ext/string/strip.rb b/activesupport/lib/active_support/core_ext/string/strip.rb
index 086c610..19213a2 100644
--- a/activesupport/lib/active_support/core_ext/string/strip.rb
+++ b/activesupport/lib/active_support/core_ext/string/strip.rb
@@ -20,7 +20,6 @@ class String
   # Technically, it looks for the least indented line in the whole string, and removes
   # that amount of leading whitespace.
   def strip_heredoc
-    indent = scan(/^[ \t]*(?=\S)/).min.try(:size) || 0
-    gsub(/^[ \t]{#{indent}}/, '')
+    gsub(/^#{scan(/^[ \t]*(?=\S)/).min}/, "".freeze)
   end
 end
```

## Memory

**Before**

```
$ MEASURE_MEMORY=yes ruby strip_heredoc.rb
Before: 44.73828125 MiB
After: 44.7734375 MiB
Diff: 0.03515625 MiB
```

**After**

```
$ MEASURE_MEMORY=yes ruby patched_strip_heredoc.rb
Before: 37.9765625 MiB
After: 38.015625 MiB
Diff: 0.0390625 MiB
```

`44.7734375 -  38.015625 = 6.75`

=> **Saves about 6.75 MiB**

## Performance

```
$ ruby -v benchmark.rb
ruby 2.2.2p95 (2015-04-13 revision 50295) [x86_64-darwin14]
Calculating -------------------------------------
            original     5.652k i/100ms
             patched     6.477k i/100ms
-------------------------------------------------
            original     54.076k (± 5.7%) i/s -    271.296k
             patched     74.557k (± 6.2%) i/s -    375.666k

Comparison:
             patched:    74557.0 i/s
            original:    54076.4 i/s - 1.38x slower
```

=> **About 38% percent faster**
