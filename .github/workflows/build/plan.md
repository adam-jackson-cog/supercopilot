# Plan Build Rules

**Mindset**: "Implement the plan" - Take a list of features/tasks and systematically implement them in the optimal order while maintaining code consistency.

## Multi-Feature Implementation

### **Implementation Sequencing [Critical]**

**Dependency-First Execution**:
- **Analyze Dependencies**: Identify which features depend on others and implement foundation features first
- **Shared Components**: Build reusable components needed by multiple features before implementing specific features
- **Infrastructure First**: Implement any shared utilities, services, or configuration changes first
- **Progressive Building**: Implement features in order that allows testing each addition incrementally

**Order Optimization**:
- **Foundation Features**: Database schemas, API endpoints, core services first
- **Core Features**: Main functionality that other features build upon
- **Enhancement Features**: Additional functionality that extends core features
- **Polish Features**: UI improvements, optimizations, and final touches

### **Consistency Management [High Priority]**

**Code Consistency Across Features**:
- **Establish Patterns**: Use first implemented feature to establish patterns for subsequent features
- **Maintain Standards**: Ensure all features follow same coding style, naming conventions, and architecture
- **Shared Resources**: Create and reuse components, utilities, and services across features
- **Integration Points**: Ensure features work together seamlessly without conflicts

**Quality Consistency**:
- **Testing Standards**: Apply same testing patterns and coverage standards to all features
- **Error Handling**: Use consistent error handling patterns across all implementations
- **Performance Standards**: Maintain same performance optimization patterns throughout
- **Security Standards**: Apply same security measures to all features

### **Implementation Strategy [Medium-High Priority]**

**Systematic Development**:
- **Feature Implementation**: Implement each feature completely before moving to next
- **Integration Testing**: Test each feature integration as features are added
- **Incremental Validation**: Ensure system remains stable after each feature addition
- **Progress Tracking**: Track completion of each feature and overall progress

**Resource Management**:
- **Code Reuse**: Maximize reuse of components and utilities across features
- **Conflict Avoidance**: Implement features to avoid merge conflicts and integration issues
- **Performance Impact**: Monitor cumulative performance impact as features are added
- **Technical Debt**: Keep technical debt minimal by maintaining clean patterns

## Multi-Feature Implementation Process

### **Preparation Phase [Important]**

**Codebase Analysis**:
- **Existing Patterns**: Study existing code patterns, architecture, and conventions
- **Shared Resources**: Identify existing components and utilities that can be reused
- **Integration Points**: Understand how new features will integrate with existing functionality
- **Technical Constraints**: Identify any technical limitations or requirements

**Implementation Planning**:
- **Feature Ordering**: Determine optimal order for implementing features
- **Shared Components**: Identify components that will be needed by multiple features
- **Integration Strategy**: Plan how features will work together
- **Testing Approach**: Plan testing strategy for multiple interconnected features

### **Implementation Phase [Execution]**

**Feature-by-Feature Development**:
1. **Implement Foundation**: Build shared components and infrastructure first
2. **Core Feature Implementation**: Implement main features in dependency order
3. **Integration Testing**: Test each feature as it's added to ensure compatibility
4. **Enhancement Implementation**: Add supporting features and improvements
5. **Final Integration**: Ensure all features work together as complete system

**Quality Assurance**:
- **Individual Feature Testing**: Test each feature thoroughly before moving to next
- **Integration Testing**: Test feature interactions as system grows
- **Performance Monitoring**: Ensure performance remains acceptable as features are added
- **Code Quality**: Maintain code quality standards across all feature implementations

### **Completion Phase [Validation]**

**System Integration**:
- **End-to-End Testing**: Test complete system with all features implemented
- **Performance Validation**: Ensure system performance meets requirements
- **User Experience**: Validate that all features work together for good user experience
- **Documentation**: Update documentation to reflect all implemented features

**Final Quality Checks**:
- **Code Review**: Review all implemented code for consistency and quality
- **Test Coverage**: Ensure adequate test coverage across all features
- **Security Review**: Validate security across all implemented features
- **Performance Optimization**: Optimize performance of complete system

## Implementation Output

**Complete Feature Set**:
- All requested features implemented and working
- Features integrate seamlessly with each other
- Consistent code quality and patterns across all features
- Comprehensive test coverage for all functionality

**System Integration**:
- All features work together as cohesive system
- No conflicts or integration issues between features
- Optimal performance with all features active
- Clean, maintainable codebase

## Quality Standards

**Implementation Quality**:
- Each feature follows established patterns and conventions
- Code is clean, readable, and maintainable
- Comprehensive test coverage for all features
- No breaking changes to existing functionality

**System Quality**:
- All features integrate properly with each other
- System performance remains optimal with all features
- User experience is consistent across all features
- Documentation is complete and accurate

## Success Criteria

**Feature Completion**:
- ✅ All requested features implemented
- ✅ All tests passing
- ✅ Features integrate properly
- ✅ Code follows project standards

**System Integration**:
- ✅ Complete system works as intended
- ✅ Performance meets requirements
- ✅ No integration conflicts
- ✅ Documentation updated