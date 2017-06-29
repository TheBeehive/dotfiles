namespace 'vim-plug' do
  desc 'Remove unused directories (PlugClean)'
  task :clean do
    sh %(vim -c "let g:plug_window = ''" +PlugClean! -c 'qa!')
  end

  desc 'Install plugins (PlugInstall)'
  task :install do
    sh %(vim -c "let g:plug_window = ''" +PlugInstall -c 'qa!')
  end

  desc 'Install or update plugins (PlugUpdate)'
  task :update do
    sh %(vim -c "let g:plug_window = ''" +PlugUpdate -c 'qa!')
  end

  desc 'Upgrade vim-plug itself (PlugUpgrade)'
  task :upgrade do
    sh %(vim -c "let g:plug_window = ''" +PlugUpgrade -c 'qa!')
  end
end

desc 'Install or update plugins (PlugUpdate)'
task 'vim-plug' => 'vim-plug:update'
