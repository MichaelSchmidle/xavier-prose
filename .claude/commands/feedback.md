# Xavier Prose Feedback System

Automated reflection on writing session to identify obstacles and propose improvements.

## Usage

```bash
# Automated session reflection
/feedback

# Quick user-initiated feedback
/feedback "Template guidance unclear for technical writing"

# Specific feedback types
/feedback feeling "Workflow feels overwhelming"
/feedback domain "Missing academic citation support"
/feedback bug "Character consistency check missed dialogue changes"
```

## Implementation

```bash
# Check if this is user-initiated feedback or automated reflection
if [ $# -gt 0 ]; then
    # User provided feedback directly
    USER_FEEDBACK="$*"
    echo "📝 Recording feedback: $USER_FEEDBACK"
    
    # Save to local feedback file
    mkdir -p .xavier-prose
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "{\"timestamp\":\"$TIMESTAMP\",\"type\":\"user\",\"content\":\"$USER_FEEDBACK\",\"synced\":false}" >> .xavier-prose/feedback.json
    
    echo "✅ Feedback saved locally. Use '/feedback sync' to submit to GitHub."
    exit 0
fi

# Automated reflection mode
echo "🤔 Reflecting on this Xavier Prose session..."
echo ""

# Analyze project context
PROSE_TYPE="unknown"
if [ -f "planning/outline.md" ]; then
    PROSE_TYPE=$(grep -i "type:" planning/outline.md | head -1 | cut -d: -f2 | xargs || echo "unknown")
fi

# Check what files were recently accessed/modified
RECENT_FILES=$(find . -name "*.md" -not -path "./xavier-prose/*" -not -path "./.git/*" -mtime -1 2>/dev/null | head -10)

echo "## Session Analysis"
echo "- **Project Type**: $PROSE_TYPE"
echo "- **Recent Files**: $(echo $RECENT_FILES | tr '\n' ', ' | sed 's/,$//')"
echo "- **Xavier Prose Version**: $(cd xavier-prose && git describe --tags 2>/dev/null || echo "main")"
echo ""

echo "## Automated Obstacle Detection"
echo ""

OBSTACLES_FOUND=0

# Check for bible consistency issues
if [ -d "bible" ]; then
    echo "### 1. Bible Cross-Reference Analysis"
    
    # Count bible files
    BIBLE_FILES=$(find bible -name "*.md" | wc -l)
    if [ $BIBLE_FILES -gt 4 ]; then
        echo "- **Issue**: Multiple bible files ($BIBLE_FILES found) may create lookup friction"
        echo "- **Impact**: Users spend time searching across files for related information"
        echo "- **Suggested Improvement**: Integrated search or cross-reference system"
        OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
    fi
    
    # Check for empty sections
    EMPTY_SECTIONS=$(find bible -name "*.md" -exec grep -l "## Example Entry" {} \; | wc -l)
    if [ $EMPTY_SECTIONS -gt 0 ]; then
        echo "- **Issue**: $EMPTY_SECTIONS bible files still contain template examples"
        echo "- **Impact**: Template noise mixed with actual content"
        echo "- **Suggested Improvement**: Template cleanup guidance or auto-detection"
        OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
    fi
    echo ""
fi

# Check for planning-manuscript alignment
if [ -d "planning" ] && [ -d "manuscript" ]; then
    echo "### 2. Planning-Manuscript Alignment"
    
    # Check if outline exists but manuscript is sparse
    if [ -f "planning/outline.md" ] && [ $(find manuscript -name "*.md" | wc -l) -lt 3 ]; then
        echo "- **Issue**: Detailed planning exists but minimal manuscript content"
        echo "- **Impact**: May indicate difficulty translating plans into prose"
        echo "- **Suggested Improvement**: Planning-to-prose bridging tools or templates"
        OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
    fi
    echo ""
fi

# Check for voice consistency challenges
if [ -d "style-guide" ] && [ -d "manuscript" ]; then
    echo "### 3. Voice Consistency Workflow"
    
    # Check if voice guide exists but is generic
    if [ -f "style-guide/voice-guide.md" ] && grep -q "## Examples of Your Voice" style-guide/voice-guide.md; then
        EXAMPLE_COUNT=$(grep -A 10 "## Examples of Your Voice" style-guide/voice-guide.md | grep "### Sample" | wc -l)
        if [ $EXAMPLE_COUNT -eq 0 ]; then
            echo "- **Issue**: Voice guide lacks actual examples from this project"
            echo "- **Impact**: Difficult to maintain voice consistency without concrete reference"
            echo "- **Suggested Improvement**: Auto-extract voice examples from manuscript"
            OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
        fi
    fi
    echo ""
fi

# Check for prose-type-specific issues
echo "### 4. Prose Type Optimization"
case $PROSE_TYPE in
    *fiction*|*novel*)
        echo "- **Focus**: Character and plot consistency"
        if [ ! -f "bible/relationships.md" ] || [ $(wc -l < bible/relationships.md) -lt 50 ]; then
            echo "- **Issue**: Minimal relationship tracking for fiction project"
            echo "- **Impact**: Risk of character relationship inconsistencies"
            echo "- **Suggested Improvement**: Enhanced relationship mapping tools"
            OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
        fi
        ;;
    *academic*|*paper*)
        echo "- **Focus**: Argument structure and citation management"
        if ! grep -q "citation" bible/established-facts.md 2>/dev/null; then
            echo "- **Issue**: No citation tracking in established facts"
            echo "- **Impact**: Risk of citation inconsistencies"
            echo "- **Suggested Improvement**: Citation management integration"
            OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
        fi
        ;;
    *technical*|*documentation*)
        echo "- **Focus**: Accuracy and user guidance"
        if [ ! -f "bible/context.md" ] || ! grep -q "technical" bible/context.md 2>/dev/null; then
            echo "- **Issue**: Missing technical context documentation"
            echo "- **Impact**: Risk of technical inconsistencies"
            echo "- **Suggested Improvement**: Technical specification tracking"
            OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
        fi
        ;;
    *)
        echo "- **Issue**: Unknown prose type - limited optimization available"
        echo "- **Impact**: Generic templates may not fit specific needs"
        echo "- **Suggested Improvement**: Prose type detection and customization"
        OBSTACLES_FOUND=$((OBSTACLES_FOUND + 1))
        ;;
esac
echo ""

# Summary
if [ $OBSTACLES_FOUND -eq 0 ]; then
    echo "## ✅ No Significant Obstacles Detected"
    echo ""
    echo "Your Xavier Prose workflow appears to be running smoothly! Keep up the great work."
    echo ""
    echo "If you've encountered any friction that wasn't detected, you can provide specific feedback:"
    echo "\`/feedback \"[describe your experience]\"\`"
else
    echo "## 📋 Summary"
    echo ""
    echo "Detected **$OBSTACLES_FOUND** potential improvement areas."
    echo ""
    echo "Would you like to submit these suggestions to help improve Xavier Prose?"
    echo ""
    echo "**Options:**"
    echo "- \`/feedback sync\` - Submit all feedback to GitHub issues"
    echo "- \`/feedback save\` - Save locally only (submit later)"
    echo "- \`/feedback discard\` - Discard this analysis"
    echo ""
    echo "These suggestions help make Xavier Prose better for everyone! 🚀"
    
    # Save analysis to local feedback
    mkdir -p .xavier-prose
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "{\"timestamp\":\"$TIMESTAMP\",\"type\":\"automated\",\"obstacles\":$OBSTACLES_FOUND,\"prose_type\":\"$PROSE_TYPE\",\"synced\":false}" >> .xavier-prose/feedback.json
fi

echo ""
echo "---"
echo "*Xavier Prose Feedback System - Making prose development better through reflection*"
```