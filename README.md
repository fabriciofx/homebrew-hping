# Fabriciofx Hping

## How create a new (tap) formula?

1. Create a new tap project using the command:

```bash
brew tap-new github-user/homebrew-program
```

For example, if `fabriciofx` is the github-user and `hping` is the program name,
so the above line becomes:

```bash
brew tap-new fabriciofx/homebrew-hping
```

This command will create a git repository for formula in
`/opt/homebrew/Library/Taps/github-user/homebrew-program`, e.g.,
`/opt/homebrew/Library/Taps/fabriciofx/homebrew-hping`.

2. Write the formula

You can follow the bellow template:

```ruby
class Program < Formula
  desc "Description of the program"
  homepage "https://example.com"
  url "https://example.com/program-0.0.1.tar.gz"
  sha256 "38c0091e8d38856cd683b99e7249458ef572a21de808e251c8b4ee144c32b875"
  license "MIT"

  # Dependencies. '=> :build' is only for build the program
  depends_on "pkgconf" => :build
  depends_on "tcl-tk"

  uses_from_macos "libpcap"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  # Caveats, if they exists
  def caveats
    <<~EOS
      program requires root privileges so you will need to run
      `sudo program`.
      You should be certain that you trust any software you grant root privileges.
    EOS
  end

  test do
    assert_path_exists bin/"program"
    assert_match "program", shell_output("#{bin}/program --help")
  end
end
```

3. Put your formula (Ruby script) in
`/opt/homebrew/Library/Taps/github-user/homebrew-program/Formula`

For example, `/opt/homebrew/Library/Taps/fabriciofx/homebrew-hping/Formula`. The
formula name must be the same of the program, `program.rb` (e.g. `hping.rb`).

4. Upload formula to a GitHub repository

- Create a repository named `homebrew-program` (e.g `homebrew-hping`) in your
GitHub account.
- Go to `/opt/homebrew/Library/Taps/github-user/homebrew-program/Formula`
(e.g. `/opt/homebrew/Library/Taps/fabriciofx/homebrew-hping/Formula`) and add
the remote server:

```bash
git remote add origin git@github:github-user/homebrew-program.git
```

E.g.

```bash
git remote add origin git@github:github-user/homebrew-program.git
```

- Upload the `homebrew-program` content repository:

```bash
git push -u origin main
```

5. Install this formula/program

Now you can install your formula/program. To do this, use the command:

```bash
brew install github-user/program/program`
```

E.g.:

```bash
brew install fabriciofx/hping/hping`
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
