#!/bin/bash

# Xavier Prose Auto-sync Setup Script
# This script helps users enable/disable automatic CLAUDE.md updates

echo "Xavier Prose - CLAUDE.md Auto-sync Setup"
echo "========================================"
echo

# Check if we're in a Xavier Prose project
if [[ ! -f "CLAUDE.md" ]]; then
    echo "❌ Error: No CLAUDE.md found. This doesn't appear to be a Xavier Prose project."
    exit 1
fi

if ! grep -q "XAVIER PROSE MODE ACTIVATED" CLAUDE.md; then
    echo "❌ Error: This doesn't appear to be a Xavier Prose project (CLAUDE.md doesn't contain Xavier Prose mode)."
    exit 1
fi

# Check current status
CURRENT_STATUS=$(grep -o '"XAVIER_PROSE_AUTO_SYNC": "[^"]*"' .claude/settings.json 2>/dev/null | cut -d'"' -f4)
if [[ -z "$CURRENT_STATUS" ]]; then
    CURRENT_STATUS="disabled"
fi

echo "Current auto-sync status: $CURRENT_STATUS"
echo

# Ask user what they want to do
echo "What would you like to do?"
echo "1) Enable auto-sync (CLAUDE.md will be updated automatically on commits)"
echo "2) Disable auto-sync"
echo "3) Check status and exit"
echo

read -p "Enter your choice (1-3): " choice

case $choice in
    1)
        echo "Enabling auto-sync..."
        
        # Create .claude directory if it doesn't exist
        mkdir -p .claude
        
        # Update or create settings.json
        if [[ -f ".claude/settings.json" ]]; then
            # Update existing file
            sed -i 's/"XAVIER_PROSE_AUTO_SYNC": "[^"]*"/"XAVIER_PROSE_AUTO_SYNC": "true"/' .claude/settings.json
        else
            # Create new settings file
            cat > .claude/settings.json << 'EOF'
{
  "env": {
    "XAVIER_PROSE_AUTO_SYNC": "true"
  },
  "description": "Xavier Prose configuration - Auto-sync enabled"
}
EOF
        fi
        
        # Install git pre-commit hook
        if [[ ! -f ".git/hooks/pre-commit" ]]; then
            cp claude-md-sync.sh .git/hooks/pre-commit
            chmod +x .git/hooks/pre-commit
            echo "✅ Installed git pre-commit hook"
        else
            echo "⚠️  Git pre-commit hook already exists. Please manually integrate claude-md-sync.sh"
        fi
        
        echo "✅ Auto-sync enabled!"
        echo "💡 CLAUDE.md will now be updated automatically when you commit changes."
        ;;
        
    2)
        echo "Disabling auto-sync..."
        
        # Update settings.json
        if [[ -f ".claude/settings.json" ]]; then
            sed -i 's/"XAVIER_PROSE_AUTO_SYNC": "[^"]*"/"XAVIER_PROSE_AUTO_SYNC": "false"/' .claude/settings.json
        fi
        
        echo "✅ Auto-sync disabled!"
        echo "💡 CLAUDE.md will no longer be updated automatically. You can manually run './claude-md-sync.sh' if needed."
        ;;
        
    3)
        echo "Current configuration:"
        if [[ -f ".claude/settings.json" ]]; then
            echo "Settings file: .claude/settings.json"
            grep -A 5 -B 5 "XAVIER_PROSE_AUTO_SYNC" .claude/settings.json || echo "Auto-sync setting not found"
        else
            echo "No .claude/settings.json found - auto-sync is disabled by default"
        fi
        
        if [[ -f ".git/hooks/pre-commit" ]]; then
            echo "Git pre-commit hook: ✅ Installed"
        else
            echo "Git pre-commit hook: ❌ Not installed"
        fi
        ;;
        
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo
echo "For more information, see the Xavier Prose documentation."