# Code Quality Analysis Rules (Hybrid)

**Mindset**: "Quality is not an accident" - Combine automated metrics with contextual maintainability assessment.

## Automated Quality Checks [Scripts]

**Complexity Metrics**: `complexity_metrics.py`
- Scans: Function length, cyclomatic complexity, deep nesting, parameter count
- Output: Complexity scores and code smell detection with severity levels

**Pattern Detection** (Planned):
- `pattern_detection.py` - Anti-patterns, SOLID violations, design smells
- `duplication_finder.py` - Code duplication and copy-paste detection

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