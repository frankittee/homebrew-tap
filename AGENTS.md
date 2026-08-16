# Project Guidelines

- Keep Formula definitions in `Formula/` and Cask definitions in `Casks/`.
- Use lowercase kebab-case filenames matching the Formula or Cask token.
- Keep Ruby definitions minimal and follow current Homebrew conventions.
- Every Formula should include a meaningful `test do` block.
- Verify download checksums and licenses before publishing.
- Run Homebrew audit, installation, and test commands before submitting changes.
- Use `mise x -- gh` to access this repository's actions and submit pull requests.
