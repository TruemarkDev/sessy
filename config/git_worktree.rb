# frozen_string_literal: true

# Enables per-worktree databases for parallel development.
# When working in a git worktree, this appends the worktree name to the database.
#
# Example: In worktree "auth-fix", database becomes "myapp_development__auth_fix"
#
# Usage in database.yml:
#   <% require_relative "git_worktree" %>
#   development:
#     database: myapp_development<%= GitWorktree.db_suffix %>

module GitWorktree
  def self.name
    git_path = File.expand_path("../.git", __dir__)
    git_dir = nil

    if File.file?(git_path)
      contents = File.read(git_path, 1024)
      if (match = contents&.match(/\Agitdir:\s*(.+)\s*\z/))
        git_dir = match[1].strip
      end
    elsif File.directory?(git_path)
      git_dir = git_path
    end

    return nil unless git_dir&.include?("/worktrees/")

    raw = git_dir.split("/worktrees/").last.split("/").first
    # Strip repo name prefix (e.g., "myapp--feature" -> "feature")
    raw = raw.split("--", 2).last if raw.include?("--")
    sanitized = raw.to_s.gsub(/[^a-zA-Z0-9_]/, "_").downcase
    sanitized.empty? ? nil : sanitized
  end

  def self.db_suffix
    worktree = name
    worktree ? "__#{worktree}" : ""
  end
end
