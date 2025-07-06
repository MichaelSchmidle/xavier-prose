#!/bin/bash

# Xavier Prose Notification Hook - Progress Tracker
# Tracks writing session metrics and progress

# Hook configuration
HOOK_NAME="progress-tracker"
HOOK_TYPE="Notification"

# Colors for output
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if we're in a Xavier Prose project
if [[ ! -f "CLAUDE.md" ]] || ! grep -q "XAVIER PROSE MODE" "CLAUDE.md"; then
    exit 0  # Not a Xavier Prose project, skip tracking
fi

# Create session tracking directory if it doesn't exist
mkdir -p .xavier-prose/sessions

# Generate session ID based on current date/time
SESSION_ID=$(date '+%Y%m%d_%H%M%S')
SESSION_FILE=".xavier-prose/sessions/$SESSION_ID.log"

# Initialize session file if it doesn't exist
if [[ ! -f "$SESSION_FILE" ]]; then
    cat > "$SESSION_FILE" << EOF
# Xavier Prose Session Log
# Session: $SESSION_ID
# Started: $(date)

## Session Metrics
- Tools Used: 0
- Files Modified: 0
- Words Added: 0
- Consistency Checks: 0

## Activity Log
EOF
fi

# Track different types of notifications
case "$CLAUDE_NOTIFICATION_TYPE" in
    "tool_use")
        echo -e "${CYAN}📊 Session tracking: Tool used${NC}"
        echo "- $(date '+%H:%M:%S') - Tool: $CLAUDE_TOOL_NAME" >> "$SESSION_FILE"
        ;;
    "file_modified")
        echo -e "${CYAN}📊 Session tracking: File modified${NC}"
        echo "- $(date '+%H:%M:%S') - Modified: $CLAUDE_FILE_PATH" >> "$SESSION_FILE"
        ;;
    "session_end")
        echo -e "${CYAN}📊 Session tracking: Session ended${NC}"
        echo "- $(date '+%H:%M:%S') - Session ended" >> "$SESSION_FILE"
        
        # Generate session summary
        echo -e "\n## Session Summary ($(date))" >> "$SESSION_FILE"
        
        # Count current manuscript words
        if [[ -d "manuscript" ]]; then
            TOTAL_WORDS=$(find manuscript -name "*.md" -exec wc -w {} \; 2>/dev/null | awk '{sum += $1} END {print sum}')
            echo "- Total manuscript words: ${TOTAL_WORDS:-0}" >> "$SESSION_FILE"
        fi
        
        # Check if bible was updated
        if [[ -d "bible" ]]; then
            BIBLE_FILES=$(find bible -name "*.md" -newer "$SESSION_FILE" 2>/dev/null | wc -l)
            echo "- Bible files updated: $BIBLE_FILES" >> "$SESSION_FILE"
        fi
        
        echo -e "${GREEN}✅ Session summary saved to $SESSION_FILE${NC}"
        ;;
    *)
        # General notification tracking
        echo "- $(date '+%H:%M:%S') - Notification: ${CLAUDE_NOTIFICATION_TYPE:-unknown}" >> "$SESSION_FILE"
        ;;
esac

# Optional: Clean up old session files (keep last 30 days)
find .xavier-prose/sessions -name "*.log" -mtime +30 -delete 2>/dev/null || true

exit 0