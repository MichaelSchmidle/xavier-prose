# Xavier Prose Hooks System

Automated prose quality control and workflow enhancements for Xavier Prose projects.

## Overview

Xavier Prose hooks integrate with Claude Code's lifecycle events to provide:
- **Pre-edit validation** - Catch consistency issues before they're written
- **Auto-bible maintenance** - Extract facts and characters automatically  
- **Progress tracking** - Session analytics without manual effort

## Hook Types

### 1. Pre-Tool Use Hook (`prose-validation.sh`)
**Triggers**: Before Edit/Write/MultiEdit operations
**Purpose**: Validates prose consistency against established bible

**Features**:
- Checks established facts consistency
- Validates primary elements alignment
- Ensures voice guide compliance
- Can block operations if validation fails

### 2. Post-Tool Use Hook (`auto-bible-update.sh`)
**Triggers**: After successful Edit/Write/MultiEdit operations
**Purpose**: Automatically extracts and suggests bible updates

**Features**:
- Scans for new character mentions
- Identifies potential factual statements
- Updates word counts and progress metrics
- Suggests bible maintenance actions

### 3. Notification Hook (`progress-tracker.sh`)
**Triggers**: During Claude Code operations
**Purpose**: Tracks writing session metrics and progress

**Features**:
- Session activity logging
- Word count tracking
- Tool usage statistics
- Automatic session summaries

## Installation

### Via `/prose` Command (Recommended)
```bash
/prose
# Choose 'y' when prompted about hooks setup
```

### Manual Installation
```bash
# Copy hook scripts to your prose project
cp xavier-prose/hooks/*.sh ./hooks/
cp xavier-prose/hooks/hooks.json ./hooks/

# Make scripts executable
chmod +x ./hooks/*.sh
```

## Configuration

### Enable Hooks in Claude Code
1. Open Claude Code settings
2. Navigate to Hooks section
3. Enable hook execution
4. Point to your `hooks/hooks.json` file

### Customize Hook Behavior
Edit `hooks/hooks.json` to enable/disable specific hooks:

```json
{
  "hooks": {
    "PreToolUse": {
      "command": "./hooks/prose-validation.sh",
      "enabled": true
    },
    "PostToolUse": {
      "command": "./hooks/auto-bible-update.sh", 
      "enabled": true
    },
    "Notification": {
      "command": "./hooks/progress-tracker.sh",
      "enabled": false
    }
  }
}
```

## Hook Environment Variables

Hooks receive the following environment variables from Claude Code:

- `CLAUDE_TOOL_NAME` - Name of the tool being executed
- `CLAUDE_TOOL_FILE_PATH` - Path to the file being modified
- `CLAUDE_NOTIFICATION_TYPE` - Type of notification (for notification hooks)

## Session Tracking

Progress tracking creates session logs in `.xavier-prose/sessions/`:
- Individual session files with timestamps
- Tool usage statistics
- Word count progression
- Bible update tracking

## Troubleshooting

### Hook Not Executing
1. Check that hooks are enabled in Claude Code settings
2. Verify script permissions: `chmod +x ./hooks/*.sh`
3. Ensure scripts have proper shebang: `#!/bin/bash`

### Validation Blocking Operations
1. Review validation output for specific issues
2. Update bible files to resolve inconsistencies
3. Temporarily disable validation in `hooks.json` if needed

### Session Tracking Issues
1. Check `.xavier-prose/sessions/` directory exists
2. Verify write permissions in project directory
3. Check disk space for session log files

## Advanced Usage

### Custom Validation Rules
Modify `prose-validation.sh` to add project-specific validation:
- Character name consistency
- Setting continuity
- Timeline validation
- Custom fact checking

### Enhanced Auto-Updates
Extend `auto-bible-update.sh` for advanced extraction:
- NLP-based entity recognition
- Relationship mapping
- Thematic analysis
- Plot point tracking

### Analytics Integration
Enhance `progress-tracker.sh` with:
- Writing velocity metrics
- Productivity patterns
- Goal tracking
- Export capabilities

## Security Notes

- Hook scripts run with your user permissions
- Review hook code before enabling
- Keep hooks updated with Xavier Prose releases
- Monitor hook execution for unexpected behavior

## Development Mode Hook

In xavier-prose development mode, there's also a git pre-commit hook that automatically updates CLAUDE.md based on committed changes, keeping the framework documentation synchronized with actual implementation progress.

## Support

For hook-related issues:
1. Check this README for troubleshooting steps
2. Review hook script logs and output
3. Test hooks individually with debug output
4. Report issues to Xavier Prose project