# Architecture Analysis Rules

**Mindset**: "How will this scale?" - Long-term maintainability over short-term convenience, systematic thinking.


## Systematic Architecture Analysis

### **System Design & Patterns [High Priority]**

**Architectural Style Assessment**:
- Monolithic vs distributed architecture alignment
- Layered architecture pattern implementation
- Event-driven architecture patterns
- Microservices boundary definitions

**Design Pattern Implementation**:
- Creational patterns: Factory, Builder, Singleton
- Structural patterns: Adapter, Decorator, Facade
- Behavioral patterns: Observer, Strategy, Command
- Pattern appropriateness for context

**Service Architecture**:
- Service boundaries & responsibilities
- API design consistency (REST/GraphQL/gRPC)
- Data flow patterns between services
- Service communication protocols

**Domain Modeling**:
- Domain-driven design implementation
- Bounded context definitions
- Aggregate design patterns
- Entity/value object distinctions

### **Layer Coupling Analysis [Critical]**

**Dependency Management**:
- Dependency inversion principle adherence
- Circular dependency detection
- Layer violation identification
- Interface segregation compliance

**Module Boundaries**:
- High cohesion within modules
- Low coupling between modules
- Clear responsibility assignments
- Information hiding implementation

**Data Flow Analysis**:
- Unidirectional vs bidirectional data flow
- State management patterns (Redux, Vuex, etc.)
- Event propagation mechanisms
- Command/query separation

**Integration Patterns**:
- Database integration approaches
- External service integration
- Message queue usage patterns
- API gateway implementations

### **Scalability Bottlenecks [High Priority]**

**Horizontal Scaling Readiness**:
- Stateless service design
- Session management strategies
- Load balancing compatibility
- Auto-scaling triggers

**Vertical Scaling Limitations**:
- Resource utilization patterns
- Memory/CPU bottleneck identification
- I/O operation efficiency
- Database connection pooling

**Performance Scaling**:
- Caching strategy implementation
- Database query optimization
- Asynchronous processing patterns
- Content delivery optimization

**Data Scaling**:
- Database sharding strategies
- Read replica utilization
- Data partitioning approaches
- ACID vs eventual consistency

### **Maintainability Assessment [Medium-High]**

**Code Organization**:
- Directory structure logic
- Module/package organization
- File naming conventions
- Code/resource separation

**Configuration Management**:
- Environment-specific configurations
- Feature flag implementations
- Secret management patterns
- Deployment configuration consistency

**Testing Architecture**:
- Test pyramid implementation
- Unit/integration/E2E test separation
- Mocking/stubbing strategies
- Test data management

**Documentation Patterns**:
- Architecture decision records (ADRs)
- API documentation completeness
- Code documentation standards
- Deployment/operations guides

### **Technology Choices Evaluation [Medium]**

**Framework Appropriateness**:
- Framework selection rationale
- Framework version currency
- Migration path availability
- Team expertise alignment

**Dependency Analysis**:
- Third-party library assessment
- Dependency update strategies
- License compatibility
- Security vulnerability tracking

**Technology Stack Coherence**:
- Language/runtime consistency
- Build tool compatibility
- Development environment parity
- Production environment alignment

## Analysis Framework

**Architecture Health Metrics**:
- **Coupling Score**: 0-100, lower is better
- **Cohesion Index**: 0-100, higher is better  
- **Complexity Rating**: Cyclomatic complexity aggregate
- **Debt Ratio**: Technical debt per component

**Scalability Readiness Matrix**:
- **User Load**: 1x, 10x, 100x capacity analysis
- **Data Growth**: Storage & query performance projections
- **Feature Velocity**: Development speed sustainability
- **Operational Complexity**: Deployment & monitoring overhead

**Risk Assessment Categories**:
- **CRITICAL**: Single points of failure, data loss risks
- **HIGH**: Performance bottlenecks, scaling limitations
- **MEDIUM**: Maintenance difficulty, team knowledge gaps
- **LOW**: Optimization opportunities, minor improvements

## Output Requirements

**Architecture Health Dashboard**:
- Visual dependency graphs
- Coupling/cohesion metrics
- Hotspot identification (high change/complexity areas)
- Trend analysis (improvement/degradation over time)

**Scaling Readiness Report**:
- Current capacity limits
- Bottleneck identification & impact
- Scaling strategy recommendations
- Resource requirement projections

**Technical Debt Analysis**:
- Debt categorization & prioritization
- Refactoring impact analysis
- Cost/benefit assessment for fixes
- Migration strategy recommendations

**Evolution Roadmap**:
- Short-term architectural improvements (< 3 months)
- Medium-term strategic changes (3-12 months)  
- Long-term vision & migration plan (1-3 years)
- Success metrics for each phase

## Symbol Legend
- 🏗 Architecture improvement needed
- 🔗 Coupling issue identified
- 📈 Scalability concern
- 🎯 Maintainability enhancement
- ⚡ Performance architecture issue
- 🔍 Requires deeper architectural analysis
- → Leads to architectural problem
- ∴ Therefore impacts system design
- ⚠ Technical debt in architecture
- ✅ Architectural principle properly implemented