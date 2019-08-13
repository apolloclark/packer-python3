# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

Docker.validate_version!

describe "Dockerfile" do
  before(:all) do
    docker_username = ENV['DOCKER_USERNAME']
    package_name    = ENV['PACKAGE_NAME']
    package_version = ENV['PACKAGE_VERSION']
    image_name      = ENV['IMAGE_NAME']

    # check for package version major usage
    if package_version.match(/(\d+).x/)
        package_version = package_version.match(/(\d+).x/)[1]
    end

    image = Docker::Image.get(
      "#{docker_username}/#{package_name}:#{package_version}-#{image_name}"
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
    command("cat /etc/*-release").stdout
  end

  def sys_user
    command("whoami").stdout.strip
  end



  it "runs the right version of Debian" do
    expect(os_version).to include("Debian")
    expect(os_version).to include("GNU/Linux 10")
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
