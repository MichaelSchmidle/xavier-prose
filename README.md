# Xavier Prose

Transform Claude Code into a powerful prose development system.

## What is Xavier Prose?

Xavier Prose repurposes Claude Code for creative writing and long-form prose instead of software development. It uses **cognitive reframing** to transform coding concepts into prose-focused workflows:

- **"Codebase"** → **"Content Universe"** (interconnected story elements)
- **"Dependencies"** → **"Content Consistency"** (established facts and character traits)
- **"Refactoring"** → **"Revision"** (improving prose while maintaining narrative integrity)
- **"Bug Fixes"** → **"Consistency Repairs"** (resolving plot holes and contradictions)
- **"Architecture"** → **"Story Structure"** (organization, pacing, thematic development)

## Quick Start

### 1. Add Xavier Prose to Your Project

```bash
# In your writing project directory
git submodule add https://github.com/MichaelSchmidle/xavier-prose.git
```

### 2. Initialize Your Prose Project

```bash
# Start Claude Code
claude-code

# Bootstrap your prose project
/prose
```

### 3. Start Writing

After running `/prose`, Claude Code automatically operates in Xavier Prose mode. It will:
- Help you develop characters and storylines
- Maintain consistency across your content
- Provide prose-focused tools and workflows
- Track your writing goals and progress

## What Gets Created

The `/prose` command creates a complete prose development environment:

```
your-project/
├── CLAUDE.md                    # Xavier Prose mode (auto-loads)
├── manuscript/                  # Your writing
│   ├── sections/               # Chapters, articles, etc.
│   ├── drafts/                 # Work-in-progress
│   └── fragments/              # Notes and ideas
├── bible/                      # Content consistency
│   ├── primary-elements.md     # Characters, concepts
│   ├── established-facts.md    # Canonical information
│   ├── context.md             # World-building, research
│   └── relationships.md        # How elements connect
├── planning/                   # Story structure
│   ├── outline.md             # Overall organization
│   ├── section-summaries.md   # Detailed breakdowns
│   └── development-notes.md   # Ideas and next steps
└── style-guide/               # Writing consistency
    ├── voice-guide.md         # Tone and style
    ├── terminology.md         # Consistent language
    └── formatting-notes.md    # Style conventions
```

## Repository Organization

### How Many Repos Should You Use?

#### **One Repo Per Publication** (Recommended Default)
```
my-novel/                   # Single book project
├── xavier-prose/          # Submodule
├── CLAUDE.md             # Auto-loads Xavier Prose mode
├── manuscript/           # Your writing
├── bible/                # Content consistency
└── planning/             # Structure and goals
```
**Best for**: Novels, academic papers, standalone books, major documentation

#### **Shared Universe Repo** (When Content Overlaps)
```
tolkien-universe/          # Multiple related works
├── xavier-prose/         # Submodule
├── CLAUDE.md            # Xavier Prose mode
├── bible/               # Shared characters, world
├── hobbit/              # Individual work
├── lotr/                # Individual work
└── silmarillion/        # Individual work
```
**Best for**: Series, shared universes, research programs, company docs

#### **Portfolio Repo** (Short-Form Content)
```
author-works/             # Multiple unrelated works
├── xavier-prose/        # Submodule
├── blog-posts/         # Different content types
├── short-stories/      # Each with own CLAUDE.md
└── academic-papers/    # Different prose modes
```
**Best for**: Blogs, articles, essays, experimental writing

### **Decision Guidelines**
- **Default**: One repo per major publication (cleaner, easier collaboration)
- **Share repos**: When bible content overlaps >60% (characters, world, concepts)
- **Portfolio repos**: For short-form or experimental content

## Key Features

### 🎯 **Automatic Mode Switching**
Once initialized, Claude Code automatically operates in prose mode for your project.

### 📚 **Content Bible System**
Track characters, world-building, and established facts to maintain consistency.

### 🔍 **Prose-Focused Tools**
- Search for character mentions and plot threads
- Analyze narrative flow and pacing
- Manage writing goals and deadlines
- Track story development and revisions

### 📝 **Flexible for Any Prose Type**
- **Fiction**: Novels, short stories, screenplays
- **Non-fiction**: Academic papers, technical documentation, business books
- **Creative non-fiction**: Memoirs, essays, journalism

## Example Workflows

### Character Development
```
# Find all mentions of a character
grep -r "Sarah" manuscript/

# Update character information
edit bible/primary-elements.md

# Check for character consistency
# Xavier Prose will cross-reference dialogue and actions
```

### Plot Consistency
```
# Search for plot threads
grep -r "time travel" manuscript/

# Verify against established rules
# Check bible/established-facts.md
```

### Writing Goals
```
# Track progress
todo "Complete Chapter 5 draft"
todo "Revise character arc for protagonist"
```

### Feedback & Improvement
```
# Automated session reflection
/feedback

# Quick user feedback
/feedback "Template guidance unclear for technical writing"

# Sync feedback to help improve Xavier Prose
/feedback sync
```

## Self-Improving System

Xavier Prose includes an intelligent feedback system that helps improve the framework based on real usage:

### Automated Reflection
```bash
/feedback
```
Xavier Prose analyzes your writing session, identifies workflow friction, and suggests specific improvements. This creates detailed feedback about:
- Bible cross-reference efficiency
- Template clarity and completeness  
- Voice consistency workflow
- Prose-type-specific optimizations

### Contributing Improvements
Your feedback helps make Xavier Prose better for everyone:
- **Automated issues**: `/feedback` creates detailed GitHub issues with specific improvement suggestions
- **User experience**: Report expectation gaps, learning curve issues, or domain-specific needs
- **Community driven**: Every user contributes to framework evolution

## Updates

To update Xavier Prose to the latest version:

```bash
cd xavier-prose
git pull origin main
cd ..
git add xavier-prose
git commit -m "Update Xavier Prose framework"
```

## Support

Xavier Prose is an experimental framework. If you encounter issues or have suggestions:

1. Check existing [issues](https://github.com/MichaelSchmidle/xavier-prose/issues)
2. Create a new issue with details about your use case
3. Contribute improvements via pull requests

## How It Works

Xavier Prose leverages Claude Code's existing capabilities:
- **File operations** manage your manuscript and content bible
- **Search tools** find story elements and check consistency  
- **Version control** tracks your writing evolution
- **Task management** organizes your writing goals

The magic happens through the `CLAUDE.md` template that reframes these development tools for prose creation.

---

*Transform your writing process with the power of Claude Code's development tools.*