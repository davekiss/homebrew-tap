class Shot < Formula
  desc "Headless macOS screenshots for AI agents: capture, mark up, redact, find (MCP)"
  homepage "https://github.com/davekiss/shot"
  url "https://github.com/davekiss/shot/releases/download/v0.1.3/shot-macos-universal.tar.gz"
  version "0.1.3"
  sha256 "138765cf51633a7c44f555d3541dc557b52826df2a4f3ee3d7a6952b44d16125"
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
