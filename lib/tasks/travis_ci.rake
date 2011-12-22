namespace :spec do
  desc "Run cukes and specs"
  task :ci => [:spec, :cucumber]
end