#!/bin/bash

# Xavier Prose CLAUDE.md Auto-sync Hook
# This script provides automated CLAUDE.md updates based on git commits
# It can be enabled/disabled through Claude Code settings

# Check if we're in a Xavier Prose project
if [[ ! -f "CLAUDE.md" ]]; then
    exit 0
fi

# Check if CLAUDE.md contains Xavier Prose mode indicator
if ! grep -q "XAVIER PROSE MODE ACTIVATED" CLAUDE.md; then
    exit 0
fi

# Check if auto-sync is enabled via environment variable
if [[ "${XAVIER_PROSE_AUTO_SYNC:-false}" != "true" ]]; then
    exit 0
fi

# Get current timestamp
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Analyze what's being committed
analyze_changes() {
    local staged_files=$(git diff --cached --name-only)
    local updates=""
    
    # Check for prose-specific changes
    if echo "$staged_files" | grep -q "\.md$" && ! echo "$staged_files" | grep -q "^CLAUDE\.md$"; then
        updates+="- Content development and prose refinement\n"
    fi
    
    if echo "$staged_files" | grep -q "bible/"; then
        updates+="- Content consistency updates (bible)\n"
    fi
    
    if echo "$staged_files" | grep -q "planning/"; then
        updates+="- Story structure and planning updates\n"
    fi
    
    if echo "$staged_files" | grep -q "style-guide/"; then
        updates+="- Voice and style guide refinements\n"
    fi
    
    # Check for technical/framework changes
    if echo "$staged_files" | grep -q "\.claude/"; then
        updates+="- Workflow and command enhancements\n"
    fi
    
    if echo "$staged_files" | grep -q "hooks/"; then
        updates+="- Development automation improvements\n"
    fi
    
    # Generic fallback for other changes
    if echo "$staged_files" | grep -q "\."; then
        local modified_areas=$(echo "$staged_files" | cut -d'/' -f1 | sort -u | tr '\n' ' ')
        if [[ -n "$modified_areas" && -z "$updates" ]]; then
            updates="- Project development in: $modified_areas\n"
        fi
    fi
    
    echo -e "$updates"
}

# Update CLAUDE.md with implementation progress
update_claude_md() {
    local updates=$(analyze_changes)
    
    # Skip if no meaningful changes or if CLAUDE.md itself is the only change
    if [[ -z "$updates" ]]; then
        return 0
    fi
    
    local temp_file=$(mktemp)
    
    # Add updates to the appropriate section
    awk -v timestamp="$TIMESTAMP" -v updates="$updates" '
    /^## Recent Progress/ { 
        print
        print "<!-- Last updated: " timestamp " -->"
        print updates
        next
    }
    /^### ✅ Completed/ { 
        print
        print "<!-- Last updated: " timestamp " -->"
        print updates
        next
    }
    /^<!-- Last updated:/ { 
        # Skip existing timestamp
        next
    }
    { print }
    ' CLAUDE.md > "$temp_file"
    
    # Only update if there were actual changes
    if ! cmp -s CLAUDE.md "$temp_file"; then
        mv "$temp_file" CLAUDE.md
        git add CLAUDE.md
        echo "📝 Updated CLAUDE.md with progress"
        return 1
    else
        rm "$temp_file"
        return 0
    fi
}

# Main execution
main() {
    # Skip if CLAUDE.md is the only staged file (avoid infinite loops)
    local staged_files=$(git diff --cached --name-only)
    if [[ "$staged_files" == "CLAUDE.md" ]]; then
        exit 0
    fi
    
    update_claude_md
}

main
exit 0