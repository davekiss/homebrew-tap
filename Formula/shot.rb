class Shot < Formula
  desc "Headless macOS screenshots for AI agents: capture, mark up, redact, find (MCP)"
  homepage "https://github.com/davekiss/shot"
  url "https://github.com/davekiss/shot/releases/download/v0.1.2/shot-macos-universal.tar.gz"
  version "0.1.2"
  sha256 "3666204ebe0653184f3749e7a763f5e3676b2927c6a1f5d6cea2c66715dbfdb4"
  license "MIT"

  depends_on :macos

  def install
    bin.install "shot"
    pkgshare.install "skills"
  end

  def caveats
    <<~EOS
      Register shot as an MCP server in your agent, e.g.:
        codex mcp add shot -- shot
        claude mcp add --scope user shot -- shot

      To give Codex or OpenCode the shot skill:
        mkdir -p ~/.agents/skills
        ln -s #{opt_pkgshare}/skills/screenshots ~/.agents/skills/screenshots

      Capturing needs Screen Recording permission for the app that runs your
      agent: System Settings > Privacy & Security > Screen Recording.
    EOS
  end

  test do
    output = pipe_output(bin/"shot", %Q({"jsonrpc":"2.0","id":1,"method":"tools/list"}\n))
    assert_match "find_sensitive", output
  end
end
