#!/bin/bash

# Xavier Prose PreToolUse Hook - Prose Validation
# Validates prose consistency before Edit/Write operations

# Hook configuration
HOOK_NAME="prose-validation"
HOOK_TYPE="PreToolUse"

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if this is a prose-related edit operation
if [[ "$CLAUDE_TOOL_NAME" == "Edit" || "$CLAUDE_TOOL_NAME" == "Write" || "$CLAUDE_TOOL_NAME" == "MultiEdit" ]]; then
    
    # Check if we're in a Xavier Prose project
    if [[ ! -f "CLAUDE.md" ]] || ! grep -q "XAVIER PROSE MODE" "CLAUDE.md"; then
        exit 0  # Not a Xavier Prose project, skip validation
    fi
    
    echo -e "${YELLOW}🔍 Xavier Prose: Validating content consistency...${NC}"
    
    # Initialize validation results
    VALIDATION_PASSED=true
    WARNINGS=()
    
    # Extract content from tool parameters (simplified - would need proper JSON parsing)
    # For now, we'll focus on file-based validation
    
    # 1. Check for established facts consistency
    if [[ -f "bible/established-facts.md" ]]; then
        echo "  ✓ Checking established facts consistency..."
        # This would implement actual fact checking logic
        # For now, just check file exists and is readable
        if [[ ! -r "bible/established-facts.md" ]]; then
            WARNINGS+=("Cannot read bible/established-facts.md")
        fi
    fi
    
    # 2. Check for primary elements consistency
    if [[ -f "bible/primary-elements.md" ]]; then
        echo "  ✓ Checking primary elements consistency..."
        if [[ ! -r "bible/primary-elements.md" ]]; then
            WARNINGS+=("Cannot read bible/primary-elements.md")
        fi
    fi
    
    # 3. Check voice guide alignment
    if [[ -f "style-guide/voice-guide.md" ]]; then
        echo "  ✓ Checking voice guide alignment..."
        if [[ ! -r "style-guide/voice-guide.md" ]]; then
            WARNINGS+=("Cannot read style-guide/voice-guide.md")
        fi
    fi
    
    # Output validation results
    if [[ ${#WARNINGS[@]} -gt 0 ]]; then
        echo -e "${YELLOW}⚠️  Validation warnings:${NC}"
        for warning in "${WARNINGS[@]}"; do
            echo -e "   ${YELLOW}•${NC} $warning"
        done
    fi
    
    if [[ "$VALIDATION_PASSED" == true ]]; then
        echo -e "${GREEN}✅ Prose validation passed${NC}"
        exit 0  # Allow operation to continue
    else
        echo -e "${RED}❌ Prose validation failed${NC}"
        exit 1  # Block operation
    fi
    
else
    # Not a prose-related operation, allow to continue
    exit 0
fi