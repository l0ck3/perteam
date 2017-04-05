Rake::Task["assets:precompile"].clear
namespace :assets do
  task 'precompile' do
    puts "#----- Precompile assets with Webpack -----#"
    sh 'webpack -p'
  end
end