class Hping3 < Formula
  desc "Network tool able to send custom TCP/IP packets"
  homepage "https://github.com/fabriciofx/hping"
  url "https://github.com/fabriciofx/hping/releases/download/3.0.0/hping3-3.0.0.tar.gz"
  sha256 "e6f92c64bb3bed5397b7e0303686231c9192143436e4bfb0e30fd8a3f68fd612"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "libpcap"
  depends_on "tcl-tk"

  on_linux do
    depends_on "gcc" => :build
    depends_on "make" => :build
    depends_on "zlib"
  end

  resource "tcl" do
    url "https://downloads.sourceforge.net/project/tcl/Tcl/9.0.2/tcl9.0.2-src.tar.gz"
    sha256 "e074c6a8d9ba2cddf914ba97b6677a552d7a52a3ca102924389a05ccb249b520"
  end

  def install
    # Configure, build and install tcl on Linux
    if OS.linux?
      resource("tcl").stage do
        Dir.chdir("unix") do
          system "./configure", "--prefix=#{buildpath}/tcl"
          system "make"
          system "make", "install"
        end
      end
      ENV.prepend_path "PATH", "#{buildpath}/tcl/bin"
      ENV.prepend_path "PKG_CONFIG_PATH", "#{buildpath}/tcl/lib/pkgconfig"
      ENV.prepend "CPATH", "#{buildpath}/tcl/include"
      ENV.prepend "LIBRARY_PATH", "#{buildpath}/tcl/lib"
    end

    # Configure, build and install hping3
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_path_exists bin/"hping3"
    assert_match "hping", shell_output("#{bin}/hping3 --help")
  end
end
