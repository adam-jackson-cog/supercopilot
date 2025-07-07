# Data Model Design Rules

**Mindset**: "Data integrity first" - Well-structured, performant data models that maintain consistency.


## Systematic Data Model Design

### **Domain Analysis & Entity Modeling [Critical]**

**Business Domain Understanding**:
- **Core Entities**: Primary business objects & their lifecycles
- **Value Objects**: Immutable objects with no identity (money, address)
- **Aggregates**: Consistency boundaries & transaction scope
- **Domain Events**: Business events that trigger state changes

**Entity Identification Process**:
- **Nouns in Requirements**: Extract entities from business requirements
- **Stakeholder Interviews**: Identify entities from user workflows
- **Existing System Analysis**: Legacy system entity extraction
- **Industry Standards**: Domain-specific standard entities & patterns

**Relationship Analysis**:
- **One-to-One**: User profile, configuration settings
- **One-to-Many**: Customer orders, blog post comments
- **Many-to-Many**: User roles, product categories
- **Hierarchical**: Organization structure, product categories

**Data Lifecycle Patterns**:
- **Create-Read-Update-Delete (CRUD)**: Standard entity operations
- **Immutable Entities**: Append-only, never modified (events, logs)
- **Soft Delete**: Logical deletion with retention
- **Temporal Data**: Historical tracking & versioning

### **Schema Design Strategy [High Priority]**

**Normalization Analysis**:
- **First Normal Form (1NF)**: Atomic values, no repeating groups
- **Second Normal Form (2NF)**: Full functional dependency on primary key
- **Third Normal Form (3NF)**: No transitive dependencies
- **Denormalization Decisions**: Performance vs consistency trade-offs

**Relational Schema Patterns**:
- **Primary Keys**: Natural vs surrogate key selection
- **Foreign Keys**: Referential integrity & cascade rules
- **Composite Keys**: Multi-column primary keys for relationships
- **Junction Tables**: Many-to-many relationship implementation

**NoSQL Schema Patterns**:
- **Document Design**: Embedded vs referenced documents
- **Collection Strategies**: Single collection vs multiple collections
- **Schema Validation**: Document structure enforcement
- **Data Distribution**: Partition key & shard key selection

**Data Type Selection**:
- **Numeric Types**: Integer ranges, decimal precision, floating point
- **String Types**: Fixed vs variable length, character encoding
- **Date/Time Types**: Timezone handling, precision requirements
- **Binary Types**: File storage, image data, serialized objects

### **Performance Optimization Design [High Priority]**

**Indexing Strategy**:
- **Primary Indexes**: Clustered index design & key selection
- **Secondary Indexes**: Query pattern analysis & index planning
- **Composite Indexes**: Multi-column index design & column order
- **Partial Indexes**: Filtered indexes for specific conditions

**Query Pattern Analysis**:
- **Read Patterns**: Query frequency, complexity, response time requirements
- **Write Patterns**: Insert/update frequency, batch operations
- **Analytical Queries**: Reporting, aggregation, time-series analysis
- **Search Requirements**: Full-text search, fuzzy matching, faceted search

**Partitioning Strategies**:
- **Horizontal Partitioning**: Range, hash, list partitioning
- **Vertical Partitioning**: Column-based data separation
- **Functional Partitioning**: Feature-based data separation
- **Geographic Partitioning**: Location-based data distribution

**Caching Layer Design**:
- **Application Cache**: In-memory cache for frequently accessed data
- **Query Result Cache**: Database query result caching
- **Distributed Cache**: Multi-server cache coordination
- **Cache Invalidation**: Cache consistency & update strategies

### **Data Integrity & Constraints [Critical]**

**Constraint Definition**:
- **Primary Key Constraints**: Unique identifier enforcement
- **Foreign Key Constraints**: Referential integrity maintenance
- **Unique Constraints**: Alternate key enforcement
- **Check Constraints**: Business rule validation

**Data Validation Rules**:
- **Format Validation**: Email, phone, URL format checking
- **Range Validation**: Numeric ranges, date ranges
- **Business Rule Validation**: Domain-specific validation logic
- **Cross-Field Validation**: Multi-field consistency checks

**Consistency Management**:
- **ACID Properties**: Atomicity, Consistency, Isolation, Durability
- **Transaction Boundaries**: Logical unit of work definition
- **Isolation Levels**: Read uncommitted, committed, repeatable read, serializable
- **Concurrency Control**: Optimistic vs pessimistic locking

**Error Handling Patterns**:
- **Constraint Violation Handling**: User-friendly error messages
- **Data Corruption Detection**: Integrity check procedures
- **Recovery Procedures**: Data restoration & correction processes
- **Audit Trail**: Change tracking & compliance requirements

### **Scalability & Distribution [Medium-High Priority]**

**Scaling Strategies**:
- **Read Replicas**: Read scaling through replication
- **Write Scaling**: Sharding & partitioning strategies
- **Geographic Distribution**: Multi-region data placement
- **Auto-Scaling**: Dynamic capacity adjustment

**Sharding Patterns**:
- **Range-Based Sharding**: Continuous value range distribution
- **Hash-Based Sharding**: Hash function data distribution
- **Directory-Based Sharding**: Lookup service for shard location
- **Composite Sharding**: Multiple sharding strategies combination

**Data Synchronization**:
- **Master-Slave Replication**: Single writer, multiple readers
- **Master-Master Replication**: Multiple writers with conflict resolution
- **Event Sourcing**: Event-based state synchronization
- **CQRS Implementation**: Command Query Responsibility Segregation

**Consistency Models**:
- **Strong Consistency**: Immediate consistency across all nodes
- **Eventual Consistency**: Convergence over time
- **Causal Consistency**: Causally related operations ordering
- **Session Consistency**: Consistency within user session

### **Data Governance & Compliance [High Priority]**

**Privacy & Compliance**:
- **GDPR Compliance**: Right to be forgotten, data portability
- **CCPA Compliance**: California Consumer Privacy Act requirements
- **HIPAA Compliance**: Healthcare data protection requirements
- **PCI DSS**: Payment card data security standards

**Data Classification**:
- **Public Data**: Freely accessible information
- **Internal Data**: Company internal information
- **Confidential Data**: Sensitive business information
- **Restricted Data**: Highly sensitive or regulated information

**Access Control Design**:
- **Row-Level Security**: User-based data access control
- **Column-Level Security**: Field-based access restrictions
- **View-Based Security**: Controlled data exposure through views
- **API-Level Security**: Application layer access control

**Audit & Monitoring**:
- **Change Auditing**: Data modification tracking
- **Access Logging**: Data access monitoring
- **Performance Monitoring**: Query performance tracking
- **Compliance Reporting**: Regulatory requirement reporting

## Data Model Design Framework

**Analysis Phase** (25%):
- Domain analysis & entity identification
- Relationship mapping & constraint definition
- Query pattern analysis & performance requirements
- Compliance & governance requirement gathering

**Design Phase** (50%):
- Schema design & normalization decisions
- Indexing strategy & performance optimization
- Constraint implementation & validation rules
- Scalability planning & distribution strategy

**Validation Phase** (15%):
- Model review & stakeholder validation
- Performance testing & optimization
- Security review & compliance verification
- Migration planning & testing

**Implementation Phase** (10%):
- Schema creation & initial data loading
- Performance monitoring & tuning
- Security implementation & access control
- Documentation & training

**Quality Gates**:
- **Domain Gate**: Comprehensive entity & relationship model
- **Performance Gate**: Validated query performance & indexing
- **Security Gate**: Security review & compliance verification
- **Implementation Gate**: Production-ready schema & migration plan

## Output Requirements

**Comprehensive Data Model**:
- Entity relationship diagram with all entities & relationships
- Detailed schema definition with constraints & indexes
- Data dictionary with field definitions & business rules
- Normalization analysis & denormalization decisions

**Performance Specifications**:
- Indexing strategy with performance justification
- Query pattern analysis & optimization plan
- Partitioning & sharding strategy for scalability
- Caching strategy & cache invalidation rules

**Governance Documentation**:
- Data classification & access control matrix
- Privacy compliance checklist & implementation
- Audit trail requirements & logging strategy
- Retention policies & archival procedures

**Implementation Assets**:
- Database creation scripts & migration files
- Test data generation scripts & procedures
- Performance benchmarks & monitoring setup
- Documentation & developer guidelines

## Symbol Legend
- 🗃 Data entity consideration
- 🔗 Relationship design needed
- 📊 Performance optimization required
- 🔒 Data security implementation
- 🎯 Data model decision point
- → Leads to data design
- ∴ Therefore impacts data integrity
- ⚠ Data modeling risk identified
- ✅ Data requirement met
- 🔍 Domain modeling research needed