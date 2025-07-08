# Verbose Fix Rules

**Mindset**: "Illuminate the darkness" - Use enhanced logging and tracing to investigate complex, intermittent, or hard-to-reproduce issues.

## Verbose Investigation Methodology

### **Enhanced Observability Strategy [Critical]**

**When to Use Verbose Mode**:
- **Intermittent Issues**: Problems that occur sporadically without clear patterns
- **Production-Only Bugs**: Issues that can't be reproduced in development
- **Complex State Issues**: Problems involving multiple components or services
- **Race Conditions**: Timing-dependent bugs requiring execution flow analysis

**Logging Enhancement Approach**:
- **Breadcrumb Trail**: Add logging to trace execution path leading to issue
- **State Snapshots**: Log complete object states at critical points
- **Timing Analysis**: Add timestamps to identify performance bottlenecks
- **Decision Points**: Log all conditional branches and their evaluation results

### **Investigation Process [High Priority]**

**Phase 1: Strategic Instrumentation**
- Identify suspected problem areas based on symptoms
- Add targeted logging around suspected code paths
- Include context (user, session, request ID) for correlation
- Deploy instrumented code to affected environment

**Phase 2: Data Collection**
- Reproduce issue with enhanced logging enabled
- Collect logs across all relevant services and components
- Gather metrics, traces, and system state information
- Ensure sufficient data for pattern analysis

**Phase 3: Analysis & Pattern Recognition**
- Correlate logs across services using request/transaction IDs
- Identify anomalies in execution patterns or timing
- Look for missing expected log entries (indicating skipped code)
- Analyze state changes leading to the issue

**Phase 4: Root Cause Identification**
- Use log evidence to narrow down exact failure point
- Identify specific conditions triggering the issue
- Validate hypothesis with additional targeted logging
- Confirm root cause with minimal reproduction case

### **Verbose Debugging Techniques [Medium Priority]**

**Execution Flow Tracing**:
- Log entry/exit of all relevant functions with parameters
- Track execution time for each operation
- Log all error conditions and recovery attempts
- Trace async operations and callback sequences

**Data Flow Analysis**:
- Log data transformations at each processing stage
- Track data validation results and rejections
- Monitor queue depths and processing delays
- Capture external API requests and responses

**State Transition Logging**:
- Log before/after states for all mutations
- Track state machine transitions and triggers
- Monitor cache hits/misses and invalidations
- Record configuration changes and feature flag evaluations

**Performance Profiling**:
- Add timing logs around suspected slow operations
- Log resource usage (memory, CPU, connections)
- Track concurrent operation counts
- Monitor lock contention and wait times

### **Production-Safe Practices [Critical]**

**Conditional Verbosity**:
- Use feature flags to enable verbose logging selectively
- Target specific users, sessions, or request patterns
- Implement automatic verbosity for error conditions
- Time-bound verbose logging to prevent log flooding

**Sensitive Data Protection**:
- Never log passwords, tokens, or API keys
- Mask or hash personally identifiable information
- Sanitize credit card and financial data
- Review logs for accidental sensitive data exposure

**Performance Considerations**:
- Use async logging to minimize performance impact
- Implement sampling for high-frequency operations
- Set appropriate log retention policies
- Monitor log volume and adjust verbosity accordingly

## Verbose Fix Framework

### **Implementation Steps**

1. **Assess Complexity**: Determine if verbose investigation is needed
2. **Plan Instrumentation**: Identify strategic logging points
3. **Deploy Enhanced Logging**: Add logging with proper safeguards
4. **Collect Evidence**: Gather comprehensive logs during issue reproduction
5. **Analyze Patterns**: Use logs to identify root cause
6. **Implement Fix**: Create targeted solution based on findings
7. **Reduce Verbosity**: Remove or disable verbose logging post-fix

### **Success Criteria**

**Investigation Success**:
- Root cause identified with concrete evidence
- Issue reproduction becomes predictable
- Fix can be validated with log evidence
- Performance impact of logging is acceptable

**Long-term Benefits**:
- Strategic logging points remain for future issues
- Improved system observability
- Faster resolution of similar issues
- Better understanding of system behavior

## Output Requirements

**Investigation Artifacts**:
- Comprehensive log analysis documenting the issue
- Root cause analysis with supporting evidence
- Reproduction steps validated by logs
- Performance impact assessment

**Enhanced System**:
- Strategic logging for ongoing observability
- Correlation IDs for request tracing
- Structured logs for automated analysis
- Documentation of logging strategy

**Fix Validation**:
- Log evidence showing issue is resolved
- Performance metrics confirming no regression
- Test cases based on discovered edge cases
- Monitoring alerts for issue recurrence