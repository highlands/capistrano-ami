namespace :ami do
  task :create do
    on roles(:all) do
      instance_id = fetch(:instance_id, nil)
      if instance_id.present?
        info "[capistrano-ami] [#{instance_id}] Creating AMI..."
        ami = Capistrano::Ami.create(instance_id, fetch(:base_ami_name, 'capistrano-ami'))
        info "[capistrano-ami] [#{instance_id}] Created AMI (#{ami.id})"
      else
        info "[capistrano-ami] Instance ID not found... Skipping AMI creation."
      end
    end
  end

  task :delete_old_amis do
    on roles(:all) do
      instance_id = fetch(:instance_id, nil)
      if instance_id.present?
        info "[capistrano-ami] [#{instance_id}] Deleting old AMIs...."
        Capistrano::Ami.old_amis(instance_id, fetch(:keep_amis, 5)).each do |ami|
          ami.deregister
          Capistrano::Ami.delete_snapshot(ami.block_device_mappings)
          info "[capistrano-ami] [#{instance_id}] Deleted AMI (#{ami.id})"
        end
        info "[capistrano-ami] [#{instance_id}] Finished deleting AMIs"
      else
        info "[capistrano-ami] Instance ID not found... Skipping AMI deletion."
      end
    end
  end
end

after 'deploy', 'ami:create'
after 'ami:create', 'ami:delete_old_amis'
