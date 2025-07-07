# SuperCopilot Dependency Strategy

**Philosophy**: Use established tools when they provide clear value, but keep dependencies minimal and optional.

## Current Dependencies

### Required Tools
- **Lizard** (`pip install lizard`)
  - **Purpose**: Multi-language code complexity analysis
  - **Justification**: Supports 20+ languages, industry-standard metrics, zero false positives
  - **Alternatives Considered**: Custom script (400+ lines, many false positives)
  - **Impact**: Replaces complex custom implementation with 50-line wrapper

### Optional Tools
- **Radon** (`pip install radon`) - Python-specific complexity metrics
- **Bandit** (`pip install bandit`) - Python security analysis
- **Safety** (`pip install safety`) - Python dependency vulnerability scanning

## Decision Framework

### ✅ Use External Dependency When:
1. **Proven tool** with wide adoption (Lizard has 1.7k GitHub stars)
2. **Replaces complex code** (saves 350+ lines of custom implementation)
3. **Eliminates false positives** (battle-tested vs our regex patterns)
4. **Multi-language support** (covers all our target languages)
5. **Stable API** (minimal breaking changes)

### ❌ Keep Custom Implementation When:
1. **Simple task** (<50 lines of straightforward code)
2. **Project-specific logic** (unique business rules)
3. **Tight integration** with our output formatting
4. **Dependency overhead** exceeds implementation complexity
5. **Unreliable or unmaintained** external tool

## Examples Applied

### Lizard (✅ Good choice)
- **Before**: 400+ line custom script with many false positives
- **After**: 50-line wrapper around battle-tested tool
- **Result**: 96% reduction in findings, all legitimate

### ESLint (✅ Good choice - project-specific)
- **Strategy**: Don't install globally, let projects configure
- **Reason**: Highly project-specific configuration
- **Fallback**: Our scripts detect if ESLint is available

### Git Operations (❌ Keep custom)
- **Reason**: Simple subprocess calls, project-specific logic
- **Implementation**: <20 lines for git commit functionality

## Installation Strategy

### Graceful Degradation
- **Core functionality** works without any dependencies
- **Enhanced features** available when tools are installed
- **Clear feedback** when tools are missing
- **Manual installation** instructions provided

### User Experience
- **install.sh** handles dependency installation
- **Optional prompts** for additional tools
- **--force** flag skips prompts for automation
- **Dry-run mode** shows what would be installed

## Future Dependencies

### Evaluation Criteria
1. **LOC Reduction**: Must save 100+ lines of custom code
2. **Quality Improvement**: Must eliminate false positives or add significant value
3. **Language Coverage**: Prefer tools that support multiple languages
4. **Maintenance**: Actively maintained with recent releases
5. **Stability**: Mature tools with stable APIs

### Potential Candidates
- **SonarQube**: Comprehensive but heavy (requires server)
- **Semgrep**: Pattern-based analysis (good for custom rules)
- **CodeQL**: GitHub's analysis engine (complex setup)

### Rejection Examples
- **pylint**: Python-only, already have Lizard + Radon
- **jshint**: JavaScript-only, prefer ESLint project integration
- **clang-tidy**: C++-only, Lizard covers complexity analysis

## Monitoring Dependencies

### Health Checks
- **Version compatibility** tests in CI
- **Fallback behavior** when tools unavailable
- **Performance impact** measurement
- **Security vulnerability** scanning

### Removal Criteria
- Tool becomes unmaintained (>1 year no updates)
- Breaking changes too frequent (>2 per year)
- Better alternative emerges
- Complexity exceeds value provided

## Implementation Guidelines

### For New Scripts
1. **Start with custom** implementation for proof of concept
2. **Measure complexity** and false positive rates
3. **Research existing tools** that solve the same problem
4. **Compare implementation effort** vs dependency value
5. **Choose approach** based on decision framework

### For Dependency Integration
1. **Wrapper pattern**: Always wrap external tools in our interface
2. **Error handling**: Graceful failure when tools unavailable
3. **Output formatting**: Convert to our standard JSON format
4. **Testing**: Verify both with and without dependencies
5. **Documentation**: Clear installation and usage instructions

This strategy ensures SuperCopilot remains lightweight while leveraging the best tools available for complex analysis tasks.