# Performance Analysis Rules

**Mindset**: "Where's the bottleneck?" - Measure first, optimize critical path, evidence-based improvements.


## Systematic Performance Analysis

### **Application Performance Profiling [Critical]**

**CPU Utilization Patterns**:
- Hot path identification using profiling data
- CPU-intensive operation detection
- Algorithm complexity analysis (O(n), O(n²), etc.)
- Thread/process utilization distribution

**Memory Management Analysis**:
- Memory allocation patterns & peak usage
- Memory leak detection (growing heap, unreleased objects)
- Garbage collection frequency & duration
- Buffer/cache size optimization opportunities

**Execution Time Profiling**:
- Function/method execution time distribution
- Critical path latency analysis
- Blocking operation identification
- Asynchronous operation efficiency

**Resource Contention**:
- Lock contention patterns
- Thread pool utilization
- I/O wait time analysis
- Deadlock risk assessment

### **Database Performance [Critical]**

**Query Performance Analysis**:
- Slow query identification (> 100ms threshold)
- Query execution plan analysis
- Index utilization assessment
- Table scan vs index scan ratios

**N+1 Query Detection**:
- ORM-generated query patterns
- Loop-based database access
- Eager vs lazy loading strategies
- Batch operation opportunities

**Database Resource Utilization**:
- Connection pool efficiency
- Transaction duration analysis
- Lock wait time assessment
- Deadlock frequency monitoring

**Schema & Indexing**:
- Missing index identification
- Index fragmentation analysis
- Redundant index detection
- Composite index optimization

### **Network & I/O Performance [High]**

**API Performance**:
- Response time distribution
- Payload size optimization
- Compression utilization
- Keep-alive connection usage

**External Service Integration**:
- Third-party API latency impact
- Timeout configuration analysis
- Circuit breaker implementation
- Retry strategy efficiency

**File I/O Operations**:
- File access pattern analysis
- Disk I/O throughput measurement
- Sequential vs random access patterns
- File caching opportunities

**Network Latency**:
- DNS lookup time analysis
- TCP connection establishment time
- SSL/TLS handshake duration
- Geographic latency considerations

### **Frontend Performance [Medium-High]**

**Loading Performance**:
- Bundle size analysis & optimization
- Critical rendering path assessment
- Resource loading waterfall analysis
- Lazy loading implementation effectiveness

**Runtime Performance**:
- JavaScript execution time profiling
- DOM manipulation efficiency
- Event handler performance
- Memory usage in browser

**Rendering Performance**:
- Layout/reflow frequency
- Paint/composite operation cost
- Animation frame rate consistency
- Virtual DOM efficiency (React, Vue)

**Caching Strategy**:
- Browser cache utilization
- Service worker effectiveness
- CDN cache hit rates
- Application cache strategies

### **Scalability Analysis [High]**

**Load Testing Results**:
- Concurrent user capacity limits
- Throughput degradation patterns
- Error rate under load
- Resource utilization scaling

**Bottleneck Identification**:
- Single points of failure
- Resource saturation thresholds
- Queue length monitoring
- Auto-scaling trigger effectiveness

**Capacity Planning**:
- Growth projection analysis
- Resource requirement forecasting
- Cost vs performance trade-offs
- Scaling strategy validation

## Analysis Framework

**Performance Metrics Dashboard**:
- **Response Time**: P50, P95, P99 percentiles
- **Throughput**: Requests/transactions per second
- **Error Rate**: 4xx/5xx error percentage
- **Resource Utilization**: CPU, memory, disk, network %

**Bottleneck Classification**:
- **CRITICAL**: > 10x slower than target, user experience severely impacted
- **HIGH**: > 3x slower than target, noticeable performance degradation
- **MEDIUM**: > 1.5x slower than target, minor user experience impact
- **LOW**: Optimization opportunities, no immediate user impact

**Performance Improvement ROI**:
- User experience impact (bounce rate, conversion)
- Infrastructure cost reduction potential
- Development team velocity improvement
- Maintenance complexity reduction

## Output Requirements

**Performance Benchmark Report**:
- Current vs target performance metrics
- Historical trend analysis
- Comparative analysis (competitors, industry standards)
- Performance regression identification

**Bottleneck Analysis**:
- Top 5 performance constraints ranked by impact
- Root cause analysis for each bottleneck
- Evidence-based impact quantification
- Dependency mapping (what affects what)

**Optimization Roadmap**:
- Quick wins (< 1 week, high impact)
- Strategic improvements (1-4 weeks, medium-high impact)
- Long-term optimizations (1-3 months, architectural changes)
- Performance monitoring enhancements

**Implementation Guide**:
- Specific optimization techniques
- Code examples for common patterns
- Tool recommendations for monitoring
- Success metrics & validation criteria

## Symbol Legend
- ⚡ Performance bottleneck identified
- 📊 Metrics/monitoring needed
- 🎯 Optimization target
- 🚀 Quick win opportunity
- 🔧 Infrastructure optimization
- 💾 Memory optimization needed
- 🗄 Database optimization required
- 🌐 Network optimization opportunity
- → Leads to performance issue
- ∴ Therefore impacts user experience