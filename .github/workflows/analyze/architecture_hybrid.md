# Architecture Analysis Rules (Hybrid)

**Mindset**: "How will this scale?" - Combine automated coupling analysis with contextual system design assessment.

## Automated Architecture Checks [Scripts]

**Coupling Analysis**: `coupling_analysis.py`
- Scans: Circular dependencies, high fan-in/fan-out, dependency chains
- Output: Module coupling metrics and dependency graph issues

**Pattern Evaluation** (Planned):
- `pattern_evaluation.py` - Design pattern detection and appropriateness
- `scalability_check.py` - Bottleneck identification in system design

## Contextual Architecture Assessment [LLM Analysis]

**System Design Review**:
- Evaluate architectural patterns vs requirements and constraints
- Assess service boundaries and domain modeling effectiveness
- Review system scalability and maintainability characteristics
- Analyze technology choices and their long-term implications

**Design Quality Assessment**:
- Evaluate SOLID principles implementation at system level
- Assess separation of concerns across architectural layers
- Review abstraction levels and interface design quality
- Analyze error handling and resilience patterns

**Evolution & Scaling Analysis**:
- Assess system's ability to evolve with changing requirements
- Evaluate scaling strategies and bottleneck identification
- Review deployment and operational complexity
- Analyze technical debt impact on architectural decisions

## Analysis Process
1. **Run coupling scripts** to identify measurable architectural issues
2. **Map system components** and their relationships for context
3. **Evaluate design patterns** and architectural decisions
4. **Assess scalability readiness** through systematic review
5. **Generate improvement roadmap** with architectural recommendations

## Architecture Assessment
- **CRITICAL**: Single points of failure, data loss risks, security vulnerabilities
- **HIGH**: Scalability bottlenecks, maintainability blockers, tight coupling
- **MEDIUM**: Design improvements, pattern misuse, moderate complexity
- **LOW**: Optimization opportunities, documentation needs, minor refactoring

## Output Requirements
- Coupling metrics with dependency analysis and hotspot identification
- Architecture health assessment with design pattern evaluation
- Scalability roadmap with bottleneck resolution strategies
- Technology recommendation with migration path planning

## Symbol Legend
- 🤖 Automated architecture analysis
- 🧠 LLM contextual assessment
- 🏗 Architecture improvement needed
- 🔗 Coupling issue identified
- 📈 Scalability concern detected