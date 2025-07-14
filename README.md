# MonitorMV

A simple tool to track your AI usage for Claude and Gemini subscriptions.

If you're like me and use AI tools for work, you've probably wondered "how much am I actually using these subscriptions?" The built-in usage meters don't always tell the full story, especially with model weighting and session windows.

MonitorMV reads your local AI logs and gives you a clearer picture of your actual usage patterns.

## What it supports
- Claude AI (Pro/Max subscriptions) 
- Google Gemini (CLI usage)

## Why I built this

AI subscription limits work differently than API billing:

### Claude Pro/Max
- Opus models use 5x resources per message
- Sonnet models use 1x resources (baseline)  
- Haiku models use 0.25x resources

### Google Gemini
- Different models have different resource costs
- Daily request limits vary by subscription tier
- Requires [Gemini CLI](https://www.npmjs.com/package/@google/gemini) installed

## What it does

- Shows real-time usage tracking for your current session
- Accounts for model weighting (Opus uses more resources than Haiku)
- Tracks multiple sessions across different projects
- Detects session windows intelligently based on your usage patterns
- Shows token statistics and estimated API costs
- Works with both local timezone and UTC display
- Updates automatically when new versions are available

The goal is just to give you a better sense of how you're using your AI subscriptions.

## Installation

### Quick install
```bash
curl -fsSL https://raw.githubusercontent.com/casuallearning/MV_Claude_Monitor/main/install.sh | bash
```

### Manual install
```bash
curl -O https://raw.githubusercontent.com/casuallearning/MV_Claude_Monitor/main/monitormv
chmod +x monitormv
sudo cp monitormv /usr/local/bin/monitormv
```

Then just run `monitormv` - it'll walk you through setup on first use.

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

## How it works

MonitorMV reads the local session files that Claude Desktop and Gemini CLI create:
- Figures out your current 5-hour session window based on when you actually use the tools
- Counts messages and applies the resource weights that match how Claude actually bills
- Shows token usage for reference (helpful for understanding API costs)
- Tries to be fast by only scanning recent files instead of your entire history

It's not perfect, but it gives a much better picture than trying to track usage manually.

## Contributing

If you find bugs or have ideas for improvements, feel free to open an issue or submit a pull request.

## License

MIT License - see LICENSE file for details

---

This is an unofficial tool, not affiliated with Anthropic or Google. Just something I built to better understand my own AI usage patterns.
