class Hping3 < Formula
  desc "Network tool able to send custom TCP/IP packets"
  homepage "https://github.com/fabriciofx/hping"
  url "https://github.com/fabriciofx/hping/releases/download/3.0.0/hping3-3.0.0.tar.gz"
  sha256 "6a530f2d3ccf26766cb662c9e5ffc651e1e707a667b34962b42a41157ec619c4"
  license "GPL-2.0-or-later"

  # Sort dependencies in alphabetical order
  depends_on "libpcap" => :build
  depends_on "pkgconf" => :build
  depends_on "tcl-tk" => :build

  def install
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
