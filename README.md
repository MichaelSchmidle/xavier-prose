# Xavier Prose

**⚠️ Experimental Framework** - Repurposes Claude Code for writing. Requires comfort with command-line tools, Git, and code editors.

Transform Claude Code into a prose development system through cognitive reframing.

## Who Is This For?

**Technically-minded writers** comfortable with:
- Command line interfaces and Git
- Code editors (VS Code, Vim) for writing
- Markdown formatting

**Not for you if**: You prefer Word, Google Docs, or Scrivener.

## Prerequisites

1. **Claude Code** - [Installation Guide](https://docs.anthropic.com/en/docs/claude-code/quickstart)
2. **Git** - For version control and submodules
3. **Code editor** - VS Code, Vim, or similar
4. **Terminal** - Basic command line comfort

## Quick Start

```bash
# Add Xavier Prose to your writing project
git submodule add https://github.com/MichaelSchmidle/xavier-prose.git

# Start Claude Code and initialize
claude-code
/prose
```

After `/prose`, Claude Code operates in Xavier Prose mode with prose-focused tools and workflows.

## Cognitive Reframing

Claude Code concepts become prose concepts:
- **"Codebase"** → **"Content Universe"** 
- **"Dependencies"** → **"Content Consistency"**
- **"Refactoring"** → **"Revision"**
- **"Bug Fixes"** → **"Consistency Repairs"**
- **"Architecture"** → **"Content Structure"**

## Project Structure

```
your-project/
├── CLAUDE.md              # Xavier Prose mode (auto-loads)
├── manuscript/            # Your writing
├── bible/                 # Content consistency (characters, facts, context)
├── planning/              # Structure and organization
└── style-guide/          # Voice and style consistency
```

## Repository Organization

- **One repo per publication** (recommended) - Novels, papers, books
- **Shared universe repo** - Series with overlapping content (>60% shared elements)
- **Portfolio repo** - Blog posts, articles, short-form content

## Key Features

- **Automatic mode switching** - Claude Code becomes prose-focused
- **Content bible system** - Track characters, facts, relationships
- **Universal prose support** - Fiction, academic, technical, business
- **Version control** - Track writing evolution with Git

## Feedback System

```bash
/feedback                    # Automated session analysis
/feedback sync              # Submit improvements to GitHub
```

Xavier Prose analyzes workflow friction and creates improvement suggestions.

**Requirements for GitHub sync**:
- GitHub CLI installed (`gh`)
- GitHub authentication (`gh auth login`)

**Fallback**: Feedback always saves locally to `.xavier-prose/feedback.json` for manual submission if needed.

## Updates

```bash
cd xavier-prose
git pull origin main
cd ..
git commit -am "Update Xavier Prose"
```

## Support

1. Check [existing issues](https://github.com/MichaelSchmidle/xavier-prose/issues)
2. Create new issues with details
3. Contribute via pull requests

---

*Experimental framework for technically-minded writers who want AI-powered prose development.*