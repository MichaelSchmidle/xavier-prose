# CLAUDE.md - Xavier Prose Development Framework

## Project Purpose

**This repository develops Xavier Prose** - a system that repurposes Claude Code for creative writing and long-form prose instead of software development.

**You are Claude Code working as a development system** to build, refine, and maintain the Xavier Prose framework. Your role is to:

- **Develop** the cognitive reframing system that transforms Claude Code into Xavier Prose
- **Maintain** templates and commands that enable prose-focused workflows  
- **Iterate** on the framework based on user feedback and testing
- **Document** the system for users who want to write prose with Claude Code

## Repository Structure

```
xavier-prose/                    # This development repo
├── CLAUDE.md                    # This file - development instructions
├── README.md                    # User-facing documentation
├── .claude/commands/            # Commands for users to bootstrap prose projects
│   └── prose.md                # Main initialization command
├── templates/                   # Files copied to user projects
│   ├── CLAUDE.md               # Xavier Prose mode instructions
│   ├── bible/                  # Content consistency templates
│   ├── planning/               # Story structure templates
│   └── style-guide/            # Voice consistency templates
└── [development files]
```

## Development Principles

**Cognitive Reframing Core**: The system works by reframing coding concepts for prose:
- **"Codebase"** → **"Content Universe"** (interconnected prose elements)
- **"Dependencies"** → **"Content Consistency"** (arguments, facts, established elements)
- **"Refactoring"** → **"Revision"** (improving prose while maintaining logical integrity)
- **"Bug Fixes"** → **"Consistency Repairs"** (resolving contradictions, factual errors)
- **"Architecture"** → **"Content Structure"** (organization, flow, thematic development)

**Template-Driven**: Users get Xavier Prose through templates that auto-load the cognitive reframing.

**Submodule Distribution**: Users add this repo as a git submodule, then run `/prose` to bootstrap their project.

## Development Focus Areas

- **Command Development**: Create and refine slash commands that bootstrap prose projects
- **Template Optimization**: Improve CLAUDE.md templates for effective cognitive reframing
- **Framework Evolution**: Enhance the prose development system based on user needs
- **Documentation**: Maintain clear instructions for users adopting Xavier Prose

## User Workflow (What We're Building)

1. **Project Setup**: User adds xavier-prose as git submodule
2. **Initialization**: User runs `/prose` command to bootstrap prose project
3. **Automatic Reframing**: CLAUDE.md template auto-loads Xavier Prose mode
4. **Prose Development**: Claude Code operates with prose-focused mindset and tools

## Current Implementation Status

### ✅ Completed
- `/prose` command for project initialization
- Optimized CLAUDE.md template with front-loaded cognitive reframing
- Complete template system (bible, planning, style-guide)
- Submodule-ready repository structure

### 🔄 In Progress
- Documentation and user guides
- Framework refinement based on testing

### 📋 Future Development
- Additional slash commands for specific prose tasks
- Advanced template variations for different prose types
- Integration with writing-specific tools and workflows

## Testing Protocol

When testing Xavier Prose:
1. Create test directory outside this repo
2. Add xavier-prose as submodule
3. Run `/prose` command
4. Verify cognitive reframing activates automatically
5. Test prose-specific workflows and tools

## Framework Evolution

This framework improves through:
- **User Feedback**: Real-world usage patterns and pain points
- **Testing Iterations**: Continuous refinement of reframing effectiveness
- **Template Updates**: Evolving best practices for prose development
- **Command Expansion**: New tools for specific prose needs

---

*You are Claude Code developing a system to transform yourself into Xavier Prose. Stay in development mode while working on this repository.*