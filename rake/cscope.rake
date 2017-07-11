desc 'Build the cross-reference and inverted index'
task :cscope do
  sh 'cscope', '-bkqRf', '.cscope'
end
