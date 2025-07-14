# MonitorMV

**Part of the Mea Vita AI Development Suite**

A universal AI usage monitor that accurately tracks resource consumption for Claude and Gemini AI subscriptions.

Built by Phil Hudson / Mea Vita - Crafting quality AI tools for the developer community.

## Currently Supported
- ✅ **Claude AI** - Full support for Pro/Max subscriptions with accurate model weighting
- ✅ **Google Gemini** - Full support for CLI usage tracking with model differentiation

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.6+-blue.svg)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)

## Why MonitorMV?

AI subscriptions don't track usage like API keys. MonitorMV provides accurate tracking for:

### Claude Pro/Max
- **Opus models** use 5x resources per message
- **Sonnet models** use 1x resources (baseline)
- **Haiku models** use 0.25x resources

### Google Gemini
- **Gemini 2.5 Pro** - State-of-the-art reasoning (1x weight)
- **Gemini 2.5 Flash** - Cost-efficient, fast responses (0.1x weight)
- **Gemini 2.0 Flash** - Next-gen with 1M token context (0.1x weight)
- **Gemini 1.5 Pro/Flash** - Previous generation models

Requires [Gemini CLI](https://www.npmjs.com/package/@google/gemini) installed

## Features

- 📊 **Real-time Usage Tracking** - Monitor resource consumption across all Claude sessions
- ⚖️ **Accurate Model Weighting** - Reflects actual resource usage (Opus 5x, Sonnet 1x, Haiku 0.25x)
- 🎯 **Multi-Session Support** - Tracks all active AI sessions across different interfaces
- ⏰ **Smart Session Windows** - Dynamic 5-hour windows based on actual usage patterns
- 📈 **Usage Predictions** - Warns if you're on track to exceed limits
- 💾 **Token Statistics** - Detailed breakdown of input, output, and cache tokens
- 🚀 **Zero Configuration** - Works out of the box, auto-detects usage
- 💰 **Cost Projections** - Shows estimated API costs based on actual token usage
- 🎨 **Subscription Aware** - Tracks free tier, paid subscriptions, and API usage differently
- 🌍 **Timezone Support** - Display times in local timezone or UTC
- 🔄 **Self-Updating** - Built-in updater with `monitormv --update`

## Quick Start

### One-line Installation

```bash
curl -fsSL https://raw.githubusercontent.com/casuallearning/MV_Claude_Monitor/main/install.sh | bash
```

After installation, MonitorMV will guide you through initial setup on first run, or you can run:
```bash
monitormv --setup
```

### Manual Installation

1. Download the tracker:
```bash
curl -O https://raw.githubusercontent.com/casuallearning/MV_Claude_Monitor/main/monitormv
chmod +x monitormv
```

2. Install to system path:
```bash
sudo cp monitormv /usr/local/bin/monitormv
```

3. Run:
```bash
monitormv
```

## Usage

### Interactive Dashboard (Default)
```bash
monitormv              # Monitor all available AI services
monitormv --claude     # Monitor only Claude
monitormv --gemini     # Monitor only Gemini
```

### Simple Text Mode
```bash
monitormv --simple
```

### Specify Your Plan
```bash
monitormv --plan pro    # Claude Pro (45 messages/5hr)
monitormv --plan max5   # Claude Max 5x (225 messages/5hr)  
monitormv --plan max20  # Claude Max 20x (900 messages/5hr)
```

### Run Once
```bash
monitormv --once        # Display current usage and exit
```

### Update MonitorMV
```bash
monitormv --update      # Check for and install updates
```

## Understanding the Display

### Resource Units
Claude Pro/Max plans work on a resource unit system:
- **Opus models**: 5 resource units per message
- **Sonnet models**: 1 resource unit per message (baseline)
- **Haiku models**: 0.25 resource units per message

### Token Weighting (Informational)
While Pro/Max plans use message-based limits, token statistics are shown for reference:
- **Input tokens**: Count as-is
- **Output tokens**: Weighted 10x (reflecting their computational cost)
- **Cache creation**: Counts toward token stats
- **Cache reads**: FREE for Pro/Max users

### Session Windows
- Claude Pro/Max operates on 5-hour rolling windows
- Windows start dynamically based on your actual usage patterns
- If you don't use Claude for 1+ hours, the next message starts a new window
- All models share the same resource pool
- Usage resets at the next window boundary

## Screenshots

### Interactive Dashboard
```
⚡ MONITORMV v5.8.0 - CLAUDE/GEMINI ⚡
Session: 10:00 - 15:00 | Resets in: 3h 24m | Plan: MAX20 | Active: 4 sessions

RESOURCE USAGE
[████████░░░░░░░░░░░░░░░░░░░░░░░░░░] 25.2%
227.5 / 900 units | 87 messages

MODEL BREAKDOWN
  🔴 Opus: 41 msgs = 205.0 units [▓▓▓▓▓░░░░░░░░░░░░░░]
  🟡 Sonnet: 42 msgs = 42.0 units [▓░░░░░░░░░░░░░░░░░░]
  🟢 Haiku: 4 msgs = 1.0 units [░░░░░░░░░░░░░░░░░░░]

TOKEN USAGE
  Input: 125,432
  Output: 18,765 (×10 weight)
  Cache: 45,123 created, 892,456 read (free)

✅ On track: 425 / 900 units
```

### Simple Mode
```
⚡ MONITORMV v5.8.0 - CLAUDE/GEMINI ⚡
============================================================
Claude window: 10:00 - 15:00 (resets in 3h 24m)
Gemini window: Today (resets in 7h 36m)
Active sessions: 4

📘 CLAUDE AI SERVICES
============================================================
🟢 USAGE: [████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 15.2%
   136.8 / 900 units (42 messages)

📊 MODEL BREAKDOWN:
   🔴 Opus: 25 messages = 125.0 units
   🟡 Sonnet: 12 messages = 12.0 units
   🟢 Haiku: 5 messages = 1.2 units

💎 GEMINI AI SERVICES
============================================================
🟢 USAGE: [██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] 5.3%
   80 / 1500 daily requests

📊 MODEL BREAKDOWN:
   💎 2.5 Pro: 75 messages
   ⚡ 2.5 Flash: 5 messages
```

## Requirements

- Python 3.6 or higher
- For Claude: Claude Desktop app installed
- For Gemini: Gemini CLI installed (`npm install -g @google/gemini`)
- macOS or Linux (Windows support coming soon)

## Troubleshooting

### "Claude directory not found"
Make sure you have:
1. Claude Desktop installed
2. Used Claude at least once to create the `.claude` directory

### "Gemini directory not found"
Make sure you have:
1. Gemini CLI installed: `npm install -g @google/gemini`
2. Used Gemini CLI at least once to create the `.gemini` directory

### "Permission denied"
Run the install with `sudo`:
```bash
sudo cp monitormv /usr/local/bin/monitormv
```

### Usage numbers seem incorrect
- The tracker only shows usage within the current 5-hour window
- Previous windows' usage is not included
- Make sure you're tracking the right plan (pro/max5/max20)
- Check timezone settings with `monitormv --setup` if times look wrong

## How It Works

MonitorMV reads the local session files created by Claude Desktop (`~/.claude/projects/*.jsonl`) and Gemini CLI (`~/.gemini/tmp/*/logs.json`) and:
1. Intelligently detects 5-hour session windows based on actual usage patterns
2. Counts user messages and their associated models
3. Applies resource weights (Opus 5x, Sonnet 1x, Haiku 0.25x)
4. Calculates token usage from API responses (for reference)
5. Tracks both subscription limits and API cost projections
6. Supports timezone display preferences (local time or UTC)

## Why Not Use Existing Tools?

Most Claude monitoring tools were built for API usage and don't understand Pro/Max subscription limits:
- They count tokens instead of messages
- They don't apply model weighting
- They don't understand 5-hour session windows
- They count cache reads as usage (which are free for Pro/Max)

MonitorMV was built specifically for AI subscriptions to provide accurate resource tracking.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - see LICENSE file for details

## Acknowledgments

Built by **Phil Hudson / Mea Vita** with insights from the Claude community and based on official Anthropic documentation about Pro/Max resource usage.

---

**MonitorMV** is part of the Mea Vita suite of AI development tools. Follow our work and discover more quality tools at [github.com/casuallearning](https://github.com/casuallearning).

**Note**: This is an unofficial tool. Not affiliated with Anthropic.
