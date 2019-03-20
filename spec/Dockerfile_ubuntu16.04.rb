# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.get(
      ENV['DOCKER_USERNAME'] + "/" + ENV['PACKAGE'] + ":" + ENV['PACKAGE_VERSION'] + "-" + ENV['IMAGE_NAME']
    )

    # https://github.com/mizzy/specinfra
    # https://docs.docker.com/engine/api/v1.24/#31-containers
    # https://github.com/swipely/docker-api
    # https://serverspec.org/resource_types.html
    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("cat /etc/os-release").stdout
  end

  def sys_user
    command("whoami").stdout.strip
  end



  it "installs the right version of Centos" do
    expect(os_version).to include("Ubuntu")
    expect(os_version).to include("16.04")
  end

  it "runs as root user" do
    expect(sys_user).to eql("root")
  end



  describe command("python --version") do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should contain ENV['PACKAGE_VERSION'] }
  end

  describe command("pip --version") do
    its(:exit_status) { should eq 0 }
  end
end
