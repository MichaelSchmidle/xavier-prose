# Xavier Prose Project Initialization

Initialize a new Xavier Prose project with complete directory structure and configuration.

## What this command does:
1. Creates Xavier Prose CLAUDE.md with cognitive reframing
2. Sets up manuscript/, bible/, planning/, style-guide/ directories
3. Creates template files for prose project management
4. Configures git repository for prose workflow
5. Optionally sets up automated prose quality control hooks
6. Optionally enables automatic CLAUDE.md updates on commits

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

# Optional: Setup CLAUDE.md auto-sync on commits
read -p "Would you like CLAUDE.md to be automatically updated when you commit changes? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔧 Setting up CLAUDE.md auto-sync..."
    
    # Create .claude directory and settings
    mkdir -p .claude
    cp xavier-prose/templates/.claude/settings.json ./.claude/
    
    # Enable auto-sync in settings
    sed -i 's/"XAVIER_PROSE_AUTO_SYNC": "false"/"XAVIER_PROSE_AUTO_SYNC": "true"/' .claude/settings.json
    
    # Copy sync script and setup git hook
    cp xavier-prose/templates/claude-md-sync.sh ./
    cp xavier-prose/templates/setup-auto-sync.sh ./
    
    # Install git pre-commit hook if none exists
    if [[ ! -f ".git/hooks/pre-commit" ]]; then
        cp claude-md-sync.sh .git/hooks/pre-commit
        chmod +x .git/hooks/pre-commit
        echo "✅ Git pre-commit hook installed!"
    else
        echo "⚠️  Git pre-commit hook already exists. Run './setup-auto-sync.sh' to configure."
    fi
    
    echo "✅ CLAUDE.md auto-sync enabled!"
    echo "📝 CLAUDE.md will now be updated automatically when you commit changes"
    echo "🔧 Run './setup-auto-sync.sh' anytime to enable/disable this feature"
else
    echo "⏭️  Skipping auto-sync setup"
    echo "💡 You can enable this later by running the xavier-prose setup-auto-sync script"
fi

echo "✅ Xavier Prose project initialized!"
echo "📝 CLAUDE.md created - Claude Code will now operate in prose mode"
echo "📁 Directory structure created: manuscript/, bible/, planning/, style-guide/"
echo "🎯 You can now start writing prose with full Xavier Prose support"
```

Run this command once to set up your writing project. After initialization, Claude Code will automatically operate in Xavier Prose mode whenever you work in this directory.