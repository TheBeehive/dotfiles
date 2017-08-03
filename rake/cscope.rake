desc 'Build the cross-reference and inverted index'
task :cscope do
  def database(root:, &block)
    return unless File.expand_path(root) == Dir.pwd
    @filelist = FileList.new do |fl|
      fl.exclude { |f| File.symlink?(f) }
      fl.instance_exec(root, &block)
    end
  end
  @filelist = []

  begin
    require File.expand_path('~/.cscope')
  rescue LoadError; end

  if @filelist.empty?
    sh 'cscope', '-bkqRf', '.cscope'
  else
    argv = 'cscope', '-bkqf', '.cscope', '-i', '-'

    # Copied from sh and sh_show_command in FileUtils from Rake
    show_command = send(:sh_show_command, argv)
    Rake.rake_output_message(show_command)

    IO.popen(argv, 'r+') do |pipe|
      @filelist.each { |f| pipe.puts(f) }
    end

    $?.success? or
      fail "Command failed with status (#{$?.exitstatus}): " +
      "[#{show_command[0, 42]}...]"
  end
end
