# Code Quality Analysis Rules (Hybrid)

**Mindset**: "Quality is not an accident" - Combine automated metrics with contextual maintainability assessment.

## Automated Quality Checks [Scripts]

**Complexity Analysis**: `complexity_lizard.py`
- Tool: Lizard - industry-standard multi-language complexity analyzer
- Languages: Python, JS/TS, Java, C#, Go, Rust, PHP, Ruby, Swift, Kotlin, C/C++
- Metrics: Cyclomatic complexity, function length, parameter count
- Thresholds: High (20+ complexity, 100+ lines), Medium (10+ complexity, 50+ lines)
- Output: JSON with actionable findings, zero false positives

**Security Scanning**: `detect_secrets.py`
- Pattern-based secret detection with context awareness
- Excludes test files and known safe configurations
- Output: High-severity findings for immediate attention

**Performance Profiling**: `profile_database.py`
- Database query analysis and N+1 detection
- File I/O pattern analysis
- Output: Performance bottlenecks with optimization suggestions

**Architecture Review**: `coupling_analysis.py`
- Dependency analysis and circular dependency detection
- Module coupling metrics (fan-in/fan-out)
- Output: Structural improvements for maintainability

## Contextual Quality Assessment [LLM Analysis]

**Architecture Quality Review**:
- Evaluate SOLID principles implementation and adherence
- Assess design patterns usage and appropriateness
- Review separation of concerns and layer coupling
- Analyze abstraction levels and interface design

**Maintainability Assessment**:
- Evaluate code readability and self-documentation
- Assess team onboarding difficulty and knowledge transfer
- Review testing strategy and coverage effectiveness
- Analyze technical debt impact on development velocity

**Code Evolution Analysis**:
- Assess refactoring safety and change impact
- Evaluate component reusability and modularity
- Review error handling patterns and robustness
- Analyze dependency management and coupling

## Analysis Process
1. **Run quality scripts** to measure objective code metrics
2. **Analyze patterns** in context of team practices and standards
3. **Evaluate maintainability** through architectural and design review
4. **Prioritize improvements** by technical debt impact and team productivity
5. **Generate action plan** with specific refactoring recommendations

## Quality Assessment
- **CRITICAL**: Security vulnerabilities, data loss risks, system instability
- **HIGH**: Performance bottlenecks, maintainability blockers, bug patterns
- **MEDIUM**: Code smells, design issues, testing gaps
- **LOW**: Style violations, minor optimizations, documentation improvements

## Output Requirements
- Quality metrics with automated analysis results and trend data
- Technical debt assessment with payback time estimates
- Refactoring roadmap prioritized by impact and effort
- Team practice recommendations for quality improvement

## Symbol Legend
- 🤖 Automated quality analysis
- 🧠 LLM contextual assessment
- 🎯 Quality improvement opportunity
- 🐛 Potential bug pattern identified
- 🏗 Architecture improvement needed