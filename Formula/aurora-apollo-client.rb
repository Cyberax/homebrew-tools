# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
class AuroraApolloClient < Formula
  desc "Apollo task scheduler"
  homepage "https://github.com/aurorasolar/apollo"
  url "https://github.com/Cyberax/homebrew-tools/raw/master/bins/apollo-release-v0.0.3.tar.gz"
  sha256 "33eeb4b74f02c6bc453623dee84bff017755e4ef3a972d973508df6e01726cc8"
#  head "git://git@github.com:aurorasolar/apollo.git", :branch=> "master"
  depends_on "go" => :build
  depends_on "dep" => :build
  conflicts_with "apollo", :because => "Also has apollo binary"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure	 
    system "bash gobuild.sh"
    system "bash -c '.gobuild/src/apollo/apollo completion > .gobuild/src/apollo/apollo_completion'"
    bin.install ".gobuild/src/apollo/apollo" => "apollo"
    bash_completion.install ".gobuild/src/apollo/apollo_completion"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test apollo-release-v`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "apollo --help"
  end
end
