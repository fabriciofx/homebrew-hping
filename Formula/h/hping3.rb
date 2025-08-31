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

  def install
    # Configure, build and install tcl on Linux
    if OS.linux?
      tcl_version = "9.0.2"
      tcl_pkg = "tcl${tcl_version}-src.tar.gz"
      tcl_url = "https://prdownloads.sourceforge.net/tcl/${tcl_pkg}"

      system "wget", tcl_url
      system "tar", "xzf", tcl_pkg
      Dir.chdir("tcl${tcl_version}/unix") do
        system "./configure", "--prefix=#{buildpath}/tcl"
        system "make", "install"
      end

      ENV.prepend_path "PATH", "#{buildpath}/tcl/bin"
      ENV.prepend_path "PKG_CONFIG_PATH", "#{buildpath}/tcl/lib/pkgconfig"
      ENV.prepend "CPATH", "#{buildpath}/tcl/include"
      ENV.prepend "LIBRARY_PATH", "#{buildpath}/tcl/lib"
    end

    # Configure, build and install hping3
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_path_exists bin/"hping3"
    assert_match "hping", shell_output("#{bin}/hping3 --help")
  end
end
