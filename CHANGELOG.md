# MonitorMV Changelog

## v5.9.0 (2025-07-14)

### Performance & User Experience
- **⚡ Significantly Faster Startup**: Only scans files modified in the last 24 hours instead of entire history
- **🎯 Manual Session Override**: New `--session-start "10:00"` flag to manually set session start time
- **⚙️ Configurable Gap Threshold**: New `--gap-hours 3.0` flag to customize when new sessions start (default now 3 hours instead of 1)
- **📝 Humble Documentation**: Rewrote README to be more conversational and less marketing-heavy
- **🔧 Smart File Scanning**: Only reads last 50 lines of recent files for session detection

### Technical Improvements
- Added `get_fast_session_window()` method for optimized session detection
- Configurable gap threshold in user preferences (defaults to 3.0 hours)
- Manual session start support in MonitorMV constructor
- Better fallback handling when file scanning fails
- Only processes messages from the last 12 hours for session detection

### Bug Fixes
- Fixed overly aggressive session detection that treated lunch breaks as new sessions
- Improved error handling for corrupted or missing files
- Better timezone handling in fast session detection

## v5.8.0 (2025-07-14)

### Major Features
- **🌍 Timezone Support**: Added configurable timezone display (local time or UTC)
- **⚡ Smart Session Detection**: Dynamic 5-hour windows based on actual usage patterns
- **🔧 Improved Terminal Display**: Fixed flashing issues in simple mode with ANSI escape sequences
- **📊 Enhanced Cost Calculations**: API cost projections now use actual token counts instead of estimates

### Claude Improvements
- **Smart Session Windows**: Session windows now start from the first message after a 1+ hour gap
- **Accurate Message Counting**: Fixed timezone conversion issues that caused incorrect message counts
- **Better Resource Tracking**: Improved accuracy of resource unit calculations
- **Enhanced Token Display**: More detailed breakdown of input, output, and cache tokens

### Gemini Improvements
- **Updated Limits**: Corrected daily limits (1500 free, 30000 paid)
- **Better Model Support**: Added support for Gemini 2.5 Pro and 2.5 Flash models
- **Improved Cost Calculations**: More accurate API cost projections for Gemini usage
- **Token Tracking**: Enhanced token usage display (when available in logs)

### User Experience
- **Separated Service Displays**: Clear visual separation between Claude and Gemini sections
- **Better Error Handling**: Improved handling of missing files and corrupted data
- **Enhanced Setup Wizard**: Updated configuration options with timezone preferences
- **Cleaner Interface**: Improved dashboard layout and information density

### Bug Fixes
- Fixed timezone conversion causing incorrect message counts
- Resolved terminal flashing in simple mode
- Corrected session window detection algorithm
- Fixed model weight calculations for resource units
- Improved file parsing robustness

### Technical Changes
- Refactored session window detection to use gap-based algorithm
- Improved UTC/local time handling throughout the codebase
- Enhanced configuration management with backward compatibility
- Better error handling for malformed log files

## v5.7.0 (Previous)

### Features
- Added Gemini AI support alongside Claude
- Implemented model-based resource weighting
- Added API cost projections
- Enhanced dashboard with dual-service support

---

**MonitorMV** is part of the Mea Vita AI Development Suite.