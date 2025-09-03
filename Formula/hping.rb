class Hping < Formula
  desc "Network tool able to send custom TCP/IP packets"
  homepage "https://github.com/fabriciofx/hping"
  url "https://github.com/fabriciofx/hping/releases/download/3.0.0/hping3-3.0.0.tar.gz"
  sha256 "38c0091e8d38856cd683b99e7249458ef572a21de808e251c8b4ee144c32b875"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "libpcap"
  depends_on "tcl-tk"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats
    <<~EOS
      hping3 requires root privileges so you will need to run `sudo hping3`.
      You should be certain that you trust any software you grant root
      privileges.
    EOS
  end

  test do
    assert_path_exists bin/"hping3"
    assert_match "hping", shell_output("#{bin}/hping3 --help")
  end
end
