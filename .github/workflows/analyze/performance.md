# Performance Analysis Rules (Hybrid)

**Mindset**: "Where's the bottleneck?" - Combine automated profiling with contextual performance assessment.

## Automated Performance Checks [Scripts]

**Database Performance**: `profile_database.py`
- Scans: N+1 queries, missing WHERE clauses, SELECT *, LIKE with wildcards
- Output: Query performance issues with line numbers and context

**Code Complexity**: `complexity_lizard.py` 
- Scans: Function length, cyclomatic complexity, deep nesting, code smells
- Output: Complexity metrics and maintainability issues

**Frontend Analysis** (Planned):
- `analyze_frontend.py` - Bundle size, render performance, memory usage
- `check_bottlenecks.py` - CPU/memory profiling patterns

## Contextual Performance Assessment [LLM Analysis]

**System Performance Review**:
- Evaluate performance requirements vs current implementation
- Assess scalability patterns and bottleneck implications
- Analyze resource utilization in business context
- Prioritize optimizations by user impact and system criticality

**Architecture Performance**:
- Review system design for performance anti-patterns
- Assess caching strategies and their effectiveness
- Evaluate data flow and processing efficiency
- Recommend architectural improvements for performance

**Load & Scaling Analysis**:
- Assess current capacity vs expected growth
- Evaluate auto-scaling and load balancing strategies
- Review performance monitoring and alerting systems
- Identify single points of failure affecting performance

## Analysis Process
1. **Run profiling scripts** to identify measurable performance issues
2. **Analyze metrics** in context of business requirements and SLAs
3. **Evaluate system design** for scalability and performance patterns
4. **Prioritize optimizations** by impact, effort, and business value
5. **Generate roadmap** combining quick wins with strategic improvements

## Performance Assessment
- **CRITICAL**: System unusable, SLA violations, user churn risk
- **HIGH**: Noticeable delays, scalability bottlenecks, resource waste
- **MEDIUM**: Sub-optimal performance, maintenance overhead
- **LOW**: Optimization opportunities, future scaling preparation

## Output Requirements
- Performance metrics with script outputs and baseline comparisons
- Bottleneck analysis with root cause identification
- Optimization roadmap prioritized by ROI and implementation effort
- Monitoring recommendations for ongoing performance tracking

## Symbol Legend
- 🤖 Automated performance analysis
- 🧠 LLM contextual assessment  
- ⚡ Performance bottleneck requiring attention
- 📊 Metrics/monitoring needed
- 🎯 Optimization target identified