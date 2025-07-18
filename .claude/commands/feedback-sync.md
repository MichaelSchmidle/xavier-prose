# Xavier Prose Feedback Sync

Submit collected feedback to GitHub issues for Xavier Prose improvement.

## Usage

```bash
# Sync all pending feedback to GitHub
/feedback sync

# Check what feedback is pending
/feedback sync status

# Clear local feedback without syncing
/feedback sync clear
```

## Implementation

```bash
# Parse command arguments
ACTION=${1:-"submit"}

case $ACTION in
    "status")
        echo "📊 Feedback Status"
        echo ""
        if [ ! -f ".xavier-prose/feedback.json" ]; then
            echo "No feedback collected yet."
            exit 0
        fi
        
        TOTAL_FEEDBACK=$(wc -l < .xavier-prose/feedback.json 2>/dev/null || echo "0")
        SYNCED_FEEDBACK=$(grep '"synced":true' .xavier-prose/feedback.json 2>/dev/null | wc -l)
        PENDING_FEEDBACK=$((TOTAL_FEEDBACK - SYNCED_FEEDBACK))
        
        echo "- **Total Feedback**: $TOTAL_FEEDBACK items"
        echo "- **Synced**: $SYNCED_FEEDBACK items"
        echo "- **Pending**: $PENDING_FEEDBACK items"
        echo ""
        
        if [ $PENDING_FEEDBACK -gt 0 ]; then
            echo "Use \`/feedback sync\` to submit pending feedback to GitHub."
        else
            echo "All feedback is up to date! 🎉"
        fi
        ;;
        
    "clear")
        echo "🗑️  Clearing local feedback..."
        rm -f .xavier-prose/feedback.json
        echo "✅ Local feedback cleared."
        ;;
        
    "submit"|"")
        echo "🚀 Syncing feedback to GitHub..."
        echo ""
        
        if [ ! -f ".xavier-prose/feedback.json" ]; then
            echo "No feedback to sync."
            exit 0
        fi
        
        # Check if GitHub CLI is available
        if ! command -v gh &> /dev/null; then
            echo "⚠️  GitHub CLI (gh) not found."
            echo ""
            echo "**Option 1**: Install GitHub CLI"
            echo "- Visit: https://cli.github.com/"
            echo "- Run: \`gh auth login\` after installation"
            echo "- Then retry: \`/feedback sync\`"
            echo ""
            echo "**Option 2**: Manual submission"
            echo "- Visit: https://github.com/MichaelSchmidle/xavier-prose/issues/new"
            echo "- Copy feedback from: \`.xavier-prose/feedback.json\`"
            echo "- Paste as issue description"
            echo ""
            echo "**Option 3**: Keep local only"
            echo "- Feedback remains in \`.xavier-prose/feedback.json\`"
            echo "- Use for your own project improvements"
            echo ""
            exit 1
        fi
        
        # Check GitHub authentication
        if ! gh auth status &>/dev/null; then
            echo "⚠️  Not authenticated with GitHub."
            echo ""
            echo "**Setup required:**"
            echo "1. Run: \`gh auth login\`"
            echo "2. Follow the authentication prompts"
            echo "3. Retry: \`/feedback sync\`"
            echo ""
            echo "**Alternative**: Manual submission"
            echo "- Visit: https://github.com/MichaelSchmidle/xavier-prose/issues/new"
            echo "- Copy feedback from: \`.xavier-prose/feedback.json\`"
            echo ""
            exit 1
        fi
        
        # Process pending feedback
        PENDING_ITEMS=$(grep '"synced":false' .xavier-prose/feedback.json 2>/dev/null || echo "")
        
        if [ -z "$PENDING_ITEMS" ]; then
            echo "No pending feedback to sync."
            exit 0
        fi
        
        SUBMISSION_COUNT=0
        
        # For each pending feedback item, create a GitHub issue
        while IFS= read -r line; do
            if echo "$line" | grep -q '"synced":false'; then
                # Extract feedback details (simplified - in real implementation would parse JSON properly)
                CONTENT=$(echo "$line" | sed 's/.*"content":"\([^"]*\)".*/\1/')
                TYPE=$(echo "$line" | sed 's/.*"type":"\([^"]*\)".*/\1/' || echo "feedback")
                TIMESTAMP=$(echo "$line" | sed 's/.*"timestamp":"\([^"]*\)".*/\1/')
                
                # Create GitHub issue
                ISSUE_TITLE="[USER-FEEDBACK] $CONTENT"
                ISSUE_BODY=$(cat <<EOF
## Xavier Prose User Feedback

**Type**: $TYPE
**Timestamp**: $TIMESTAMP
**Auto-generated**: Yes

### Feedback Content
$CONTENT

### Context
- **Generated by**: Xavier Prose automated reflection
- **Purpose**: Improve framework based on real usage patterns
- **Action**: Review and prioritize for development

---
*This issue was created automatically by the Xavier Prose feedback system.*
EOF
)
                
                echo "Creating issue: $CONTENT"
                ISSUE_URL=$(gh issue create \
                    --repo MichaelSchmidle/xavier-prose \
                    --title "$ISSUE_TITLE" \
                    --body "$ISSUE_BODY" \
                    --label "user-feedback,automated" 2>/dev/null)
                
                if [ $? -eq 0 ]; then
                    echo "✅ Issue created: $ISSUE_URL"
                    SUBMISSION_COUNT=$((SUBMISSION_COUNT + 1))
                    
                    # Mark as synced (simplified - real implementation would update JSON properly)
                    sed -i 's/"synced":false/"synced":true/' .xavier-prose/feedback.json 2>/dev/null
                else
                    echo "❌ Failed to create issue for: $CONTENT"
                fi
            fi
        done < .xavier-prose/feedback.json
        
        echo ""
        echo "📈 Sync Complete"
        echo "- **Issues Created**: $SUBMISSION_COUNT"
        echo "- **View Issues**: https://github.com/MichaelSchmidle/xavier-prose/issues"
        echo ""
        echo "Thank you for helping improve Xavier Prose! 🙏"
        ;;
        
    *)
        echo "Unknown action: $ACTION"
        echo "Usage: /feedback sync [submit|status|clear]"
        exit 1
        ;;
esac
```