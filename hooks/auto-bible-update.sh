#!/bin/bash

# Xavier Prose PostToolUse Hook - Auto Bible Update
# Automatically extracts facts and elements after successful prose operations

# Hook configuration
HOOK_NAME="auto-bible-update"
HOOK_TYPE="PostToolUse"

# Colors for output
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if this is a prose-related edit operation
if [[ "$CLAUDE_TOOL_NAME" == "Edit" || "$CLAUDE_TOOL_NAME" == "Write" || "$CLAUDE_TOOL_NAME" == "MultiEdit" ]]; then
    
    # Check if we're in a Xavier Prose project
    if [[ ! -f "CLAUDE.md" ]] || ! grep -q "XAVIER PROSE MODE" "CLAUDE.md"; then
        exit 0  # Not a Xavier Prose project, skip auto-update
    fi
    
    echo -e "${BLUE}📚 Xavier Prose: Auto-updating bible...${NC}"
    
    # Get the file that was modified (simplified extraction)
    MODIFIED_FILE=""
    if [[ -n "$CLAUDE_TOOL_FILE_PATH" ]]; then
        MODIFIED_FILE="$CLAUDE_TOOL_FILE_PATH"
    fi
    
    # Track what we've updated
    UPDATES=()
    
    # 1. Extract potential character mentions
    if [[ -n "$MODIFIED_FILE" ]] && [[ -f "$MODIFIED_FILE" ]]; then
        echo "  ✓ Scanning for character mentions..."
        
        # Look for proper nouns that might be characters (very basic implementation)
        # This would be enhanced with more sophisticated NLP
        CHARACTER_MENTIONS=$(grep -oE '[A-Z][a-z]+' "$MODIFIED_FILE" | sort -u | head -10)
        
        if [[ -n "$CHARACTER_MENTIONS" && -f "bible/primary-elements.md" ]]; then
            # Check if these are new characters not in the bible
            while read -r char; do
                if [[ -n "$char" ]] && ! grep -q "$char" "bible/primary-elements.md"; then
                    echo "    → Potential new character: $char"
                    UPDATES+=("Character mention: $char")
                fi
            done <<< "$CHARACTER_MENTIONS"
        fi
    fi
    
    # 2. Update word counts and progress metrics
    if [[ -d "manuscript" ]]; then
        echo "  ✓ Updating progress metrics..."
        
        TOTAL_WORDS=$(find manuscript -name "*.md" -exec wc -w {} \; 2>/dev/null | awk '{sum += $1} END {print sum}')
        if [[ -n "$TOTAL_WORDS" ]]; then
            echo "    → Current word count: $TOTAL_WORDS"
            
            # Update progress file if it exists
            if [[ -f "planning/development-notes.md" ]]; then
                # Add timestamp and word count (basic implementation)
                DATE=$(date '+%Y-%m-%d %H:%M')
                echo "<!-- Auto-generated: $DATE - Word count: $TOTAL_WORDS -->" >> "planning/development-notes.md"
                UPDATES+=("Word count: $TOTAL_WORDS")
            fi
        fi
    fi
    
    # 3. Check for new facts that might need bible updates
    if [[ -n "$MODIFIED_FILE" ]] && [[ -f "$MODIFIED_FILE" ]]; then
        echo "  ✓ Scanning for factual statements..."
        
        # Look for patterns that might indicate facts (basic implementation)
        FACT_PATTERNS=$(grep -E "(was|is|are|were) [a-z]+" "$MODIFIED_FILE" | head -5)
        if [[ -n "$FACT_PATTERNS" ]]; then
            echo "    → Found potential facts to review"
            UPDATES+=("Factual statements detected")
        fi
    fi
    
    # Output summary
    if [[ ${#UPDATES[@]} -gt 0 ]]; then
        echo -e "${YELLOW}📝 Bible updates suggested:${NC}"
        for update in "${UPDATES[@]}"; do
            echo -e "   ${YELLOW}•${NC} $update"
        done
        echo -e "${YELLOW}💡 Review and manually update bible files as needed${NC}"
    else
        echo -e "${GREEN}✅ No automatic bible updates needed${NC}"
    fi
    
else
    # Not a prose-related operation, skip
    exit 0
fi