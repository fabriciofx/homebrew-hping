class Hping3 < Formula
  desc "Network tool able to send custom TCP/IP packets"
  homepage "https://github.com/fabriciofx/hping"
  url "https://github.com/fabriciofx/hping/releases/download/3.0.0-alpha-1/hping3-3.0.0-alpha-1.tar.gz"
  version "3.0.0-alpha-1"
  sha256 "11d06dd4fbf5a3ba0254a066e7d0a4e1914c2bf809ce434fe01b62e6b99676cb"
  license "GPL-2.0-or-later"

  depends_on "libpcap"
  depends_on "tcl-tk"

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
