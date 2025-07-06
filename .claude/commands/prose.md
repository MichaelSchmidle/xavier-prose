# Xavier Prose Project Initialization

Initialize a new Xavier Prose project with complete directory structure and configuration.

## What this command does:
1. Creates Xavier Prose CLAUDE.md with cognitive reframing
2. Sets up manuscript/, bible/, planning/, style-guide/ directories
3. Creates template files for prose project management
4. Configures git repository for prose workflow
5. Optionally sets up automated prose quality control hooks

## Usage:
```
/prose
```

## Implementation:

```bash
# Create Xavier Prose directory structure
mkdir -p manuscript/sections manuscript/drafts manuscript/fragments
mkdir -p bible planning style-guide

# Copy Xavier Prose CLAUDE.md template
cp xavier-prose/templates/CLAUDE.md ./CLAUDE.md

# Create bible template files
cp xavier-prose/templates/bible/primary-elements.md ./bible/
cp xavier-prose/templates/bible/context.md ./bible/
cp xavier-prose/templates/bible/established-facts.md ./bible/
cp xavier-prose/templates/bible/relationships.md ./bible/

# Create planning template files
cp xavier-prose/templates/planning/outline.md ./planning/
cp xavier-prose/templates/planning/section-summaries.md ./planning/
cp xavier-prose/templates/planning/development-notes.md ./planning/

# Create style guide template files
cp xavier-prose/templates/style-guide/voice-guide.md ./style-guide/
cp xavier-prose/templates/style-guide/terminology.md ./style-guide/
cp xavier-prose/templates/style-guide/formatting-notes.md ./style-guide/

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    git init
fi

# Create initial commit
git add .
git commit -m "Initialize Xavier Prose project

🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Optional: Setup hooks for automated prose quality control
read -p "Would you like to set up automated prose quality control hooks? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔧 Setting up Xavier Prose hooks..."
    
    # Create hooks directory
    mkdir -p hooks
    
    # Copy hook scripts
    cp xavier-prose/hooks/prose-validation.sh ./hooks/
    cp xavier-prose/hooks/auto-bible-update.sh ./hooks/
    cp xavier-prose/hooks/progress-tracker.sh ./hooks/
    
    # Make scripts executable
    chmod +x ./hooks/*.sh
    
    # Copy hooks configuration
    cp xavier-prose/hooks/hooks.json ./hooks/
    
    echo "✅ Hooks installed!"
    echo "📋 Edit hooks/hooks.json to customize hook behavior"
    echo "🔧 Configure Claude Code to use hooks: Settings → Hooks → Enable"
else
    echo "⏭️  Skipping hooks setup"
fi

echo "✅ Xavier Prose project initialized!"
echo "📝 CLAUDE.md created - Claude Code will now operate in prose mode"
echo "📁 Directory structure created: manuscript/, bible/, planning/, style-guide/"
echo "🎯 You can now start writing prose with full Xavier Prose support"
```

Run this command once to set up your writing project. After initialization, Claude Code will automatically operate in Xavier Prose mode whenever you work in this directory.