# Root Cause Analysis Rules (Hybrid)

**Mindset**: "Find the why, not just the what" - Combine systematic investigation with evidence-based analysis.

## Automated Investigation Tools [Scripts]

**Code Analysis** (Planned):
- `.github/scripts/analyze/root_cause/trace_execution.py` - Call path analysis and dependency mapping  
- `.github/scripts/analyze/root_cause/recent_changes.py` - Git blame analysis for change correlation
- `.github/scripts/analyze/root_cause/error_patterns.py` - Pattern matching for known failure modes

**Data Collection**:
- Log aggregation and timeline analysis
- Stack trace parsing and correlation
- Performance metric correlation
- Change history impact assessment

## Five-Whys Investigation [LLM Analysis]

**Systematic Questioning**:
- **Why 1**: Surface-level symptom identification
- **Why 2**: Immediate cause investigation  
- **Why 3**: Contributing factor analysis
- **Why 4**: Systemic pattern recognition
- **Why 5**: Root organizational/architectural cause

**Evidence Collection**:
- Document each "why" with concrete evidence
- Cross-reference multiple data sources
- Validate hypotheses with additional investigation
- Eliminate contradictory explanations

**Investigation Framework**:
- Reproduce issue with minimal steps
- Identify affected components and timeline
- Analyze recent changes and deployments
- Review logs, metrics, and monitoring data
- Map data flow and execution paths

## Analysis Process

1. **Issue Definition** - Clearly document the problem symptoms
2. **Evidence Gathering** - Run automated analysis tools for data collection
3. **Five-Whys Execution** - Systematic questioning with evidence validation
4. **Pattern Recognition** - Identify systemic vs isolated issues
5. **Root Cause Validation** - Verify findings through additional investigation
6. **Prevention Strategy** - Propose systemic improvements

## Investigation Depth

- **SURFACE**: Immediate symptoms and error messages
- **TECHNICAL**: Code paths, dependencies, and system interactions
- **PROCESS**: Development, deployment, and operational procedures
- **SYSTEMIC**: Architectural patterns and organizational factors

## Output Requirements

- Documented five-whys analysis chain with evidence
- Root cause identification with validation
- Contributing factor analysis
- Timeline reconstruction of events
- Prevention recommendations and systemic improvements

## Symbol Legend

- = Investigation phase requiring evidence collection
- S Why-level questioning requiring deeper analysis
- =Ë Evidence documentation and validation required
- <¯ Root cause identified with supporting evidence
- =á Prevention strategy requiring systemic changes
- ’ Leads to deeper investigation layer
- 4 Therefore represents logical conclusion with evidence