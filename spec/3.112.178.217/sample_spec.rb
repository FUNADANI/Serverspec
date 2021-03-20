# spec/spec_helper.rbを実行する
require 'spec_helper'

# Gitがインストールされているか
describe package('git') do
  it { should be_installed }
end

# rbenvがインストールされているか
describe file('/home/ec2-user/.rbenv') do
  it { should exist}
  it { should be_directory }
end

# ruby-buildがインストールされているか
describe file('/home/ec2-user/.rbenv/plugins/ruby-build') do
  it { should exist}
  it { should be_directory }
end

# Ruby2.7.2がインストールされているか
describe command('ruby -v') do
  its(:stdout) { should match /ruby 2\.7\.2/ }
end

# Node.jsがインストールされているか
describe command('node -v') do
  its(:stdout) { should match /v12\.21\.0/ }
end

# Yarnがインストールされているか
describe command('yarn -v') do
  its(:stdout) { should match /1\.22\.5/ }
end

# Rails6.1.0がインストールされているか
describe package('rails') do
  it { should be_installed.by('gem').with_version('6.1.0') }
end



# グループ名"ec2-user"が存在するか
describe group('ec2-user') do
  it { should exist }
end

# ユーザ名"ec2-user"が存在するか
describe user('ec2-user') do
  it { should belong_to_group 'ec2-user' }
end

# SSHディレクトリのオーナーとパーミッションの確認
home_dir = "/home/ec2-user"
describe file("#{home_dir}/.ssh") do
  it { should be_directory }
  it { should be_owned_by('ec2-user') }
  it { should be_grouped_into('ec2-user') }
  it { should be_mode '700' }
end

# ポート80番をListenしているか
describe port(80) do
  it { should be_listening }
end

# ポート3000番をListenしているか
describe port(3000) do
  it { should be_listening }
end