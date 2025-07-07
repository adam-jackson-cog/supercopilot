# Performance Fix Rules

**Mindset**: "Make it fast, measure twice" - Optimize based on evidence, not assumptions.

## Performance Methodology

**Profiling Phase**
- Establish baseline performance metrics (response time, memory, CPU)
- Identify specific bottlenecks using profiling tools
- Measure actual vs expected performance characteristics
- Isolate performance-critical code paths

**Analysis Phase**
- Analyze algorithmic complexity and data structures
- Identify inefficient database queries, API calls, or I/O operations
- Review memory allocation patterns and potential leaks
- Check for unnecessary computational overhead

**Optimization Phase**
- Implement targeted optimizations for identified bottlenecks
- Use appropriate data structures and algorithms for the use case
- Optimize database queries, add indexes, implement caching
- Reduce memory allocations and improve garbage collection

**Validation Phase**
- Measure performance improvements with identical test conditions
- Verify no functional regressions introduced
- Test under realistic load conditions
- Document performance gains achieved