desc 'update avatar paths on locally mounted s3'
task :migrate_avatars_on_s3 => :environment do
  Member.all.each do |member|
    if member.avatar?
      user = member.user
  
      old_path='/Volumes/s3.amazonaws.com/eightythousand.org/profiles/'
      new_path='/Volumes/s3.amazonaws.com/eightythousand.org/avatars/'

      ['medium','original','small','thumb'].each do |dir|
        cmd = ("cp -r #{old_path + dir + "/#{member.id}"} #{new_path + dir + "/#{user.id}"}")
        system(cmd)
        puts cmd
        puts "Copied #{dir} for #{user.name}"
      end
    end
  end
end
