# Code Quality Analysis Rules

**Mindset**: "Quality is not an accident" - Systematic evaluation of maintainability, reliability & performance.


## Systematic Code Analysis

### **Quality Review [High Priority]**

**Naming Conventions**:
- Variable/function names: descriptive, intention-revealing
- Class/component names: noun phrases, clear responsibility
- Constants: UPPER_SNAKE_CASE, meaningful names
- File/directory structure: logical organization

**Code Structure & Organization**:
- Single Responsibility Principle (SRP) adherence
- Function length: < 20 lines ideal, < 50 max
- Class complexity: cohesive methods, limited responsibilities
- Module dependencies: minimal coupling, clear interfaces

**DRY Principle Violations**:
- Duplicate logic detection across files
- Copy-paste code patterns
- Repeated configuration/constants
- Similar functions w/ minor variations

**Code Complexity Metrics**:
- Cyclomatic complexity: < 10 per function
- Nesting depth: < 4 levels maximum
- Parameter count: < 5 parameters per function
- Cognitive load assessment

### **Bug Detection Patterns [Critical]**

**Null/Undefined Handling**:
- Null pointer dereference risks
- Optional chaining usage (JS/TS)
- Null checks before operations
- Default value assignments

**Boundary Condition Errors**:
- Array index out of bounds
- Off-by-one errors in loops
- String manipulation edge cases
- Numeric overflow/underflow

**Type Safety Issues**:
- Implicit type conversions
- Type assertion safety (TypeScript)
- Dynamic typing risks (Python/JS)
- Interface contract violations

**Concurrency & Threading**:
- Race condition potential
- Deadlock risk patterns
- Shared state mutations
- Async/await error handling

**Memory Management**:
- Memory leak patterns
- Resource cleanup (file handles, connections)
- Circular reference detection
- Event listener cleanup

### **Performance Anti-Patterns [Medium-High]**

**Algorithmic Inefficiency**:
- O(n²) operations in hot paths
- Unnecessary nested loops
- Inefficient search/sort algorithms
- Redundant calculations

**Database Performance**:
- N+1 query problems
- Missing database indexes
- Inefficient JOIN operations
- Large result set fetching

**Frontend Performance**:
- Excessive DOM manipulations
- Unoptimized re-renders (React)
- Large bundle sizes
- Blocking operations in UI thread

**Resource Utilization**:
- Memory allocation patterns
- CPU-intensive operations
- Network request optimization
- Caching opportunities

### **Architecture & Design [Medium]**

**SOLID Principles**:
- Single Responsibility violations
- Open/Closed principle adherence
- Liskov Substitution compliance
- Interface Segregation implementation
- Dependency Inversion patterns

**Design Pattern Usage**:
- Appropriate pattern selection
- Pattern implementation correctness
- Over-engineering detection
- Anti-pattern identification

**Layer Coupling Analysis**:
- Tight coupling between layers
- Circular dependencies
- Inappropriate abstractions
- Separation of concerns

**Maintainability Factors**:
- Code readability score
- Documentation completeness
- Test coverage adequacy
- Refactoring safety

## Analysis Framework

**Quality Metrics**:
- **Maintainability Index**: 0-100 scale
- **Technical Debt Ratio**: Issues per KLOC
- **Code Coverage**: Statement/branch coverage %
- **Complexity Score**: Weighted average complexity

**Priority Classification**:
- **CRITICAL**: Security vulnerabilities, data loss risks
- **HIGH**: Performance bottlenecks, reliability issues
- **MEDIUM**: Maintainability concerns, code smells
- **LOW**: Style violations, minor optimizations

**Impact Assessment**:
- Development velocity impact
- Bug introduction likelihood
- Maintenance cost estimation
- Team onboarding difficulty

## Output Requirements

**Quality Report Structure**:
- Executive summary w/ key metrics
- Detailed findings by category
- Trend analysis (if historical data)
- Actionable improvement recommendations

**Technical Debt Analysis**:
- Debt classification & quantification
- Payback time estimation
- Refactoring priority matrix
- Risk assessment for delayed fixes

**Performance Optimization Plan**:
- Bottleneck identification & ranking
- Performance improvement estimates
- Implementation effort assessment
- Monitoring recommendations

**Code Review Checklist**:
- Automated checks to implement
- Manual review focus areas
- Team training recommendations
- Tool configuration suggestions

## Symbol Legend
- 🎯 Quality improvement opportunity
- 🐛 Potential bug pattern
- ⚡ Performance optimization needed
- 🏗 Architecture improvement required
- 📊 Metrics/measurement needed
- → Leads to quality issue
- ∴ Therefore impacts maintainability
- ⚠ Technical debt accumulation
- ✅ Quality standard met
- 🔍 Requires detailed investigation