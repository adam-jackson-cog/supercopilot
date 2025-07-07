# Feature Build Rules

**Mindset**: "Implement the feature" - Take the given feature specification and build it following existing code patterns and maintaining consistency.

## Single Feature Implementation

### **Pattern-Following Implementation [Critical]**

**Code Consistency**:
- **Follow Existing Patterns**: Analyze codebase for established patterns and architectural choices
- **Maintain Style**: Use same naming conventions, file structure, and coding style
- **Reuse Components**: Leverage existing components, utilities, and services where applicable
- **Consistent Dependencies**: Use same libraries and frameworks already in the project

**Implementation Process**:
- **Understand Requirements**: Analyze the feature specification thoroughly
- **Identify Touch Points**: Find which files/components need modification or creation
- **Implement Incrementally**: Build feature step-by-step with working states
- **Include Tests**: Write tests that match existing test patterns and coverage

### **Quality Implementation Standards [High Priority]**

**Code Quality**:
- **Type Safety**: Follow existing TypeScript/type patterns in the codebase
- **Error Handling**: Implement error handling consistent with existing error patterns
- **Performance**: Follow existing performance patterns and optimization approaches
- **Security**: Apply same security patterns used elsewhere in codebase

### **Implementation Workflow [Medium Priority]**

**Step-by-Step Process**:
1. **Analyze Codebase**: Study existing architecture and patterns first
2. **Create/Modify Files**: Implement the feature following established patterns
3. **Add Tests**: Write tests that match existing test structure and style
4. **Validate Integration**: Ensure feature works with existing functionality
5. **Clean Up**: Remove debugging code, optimize imports, fix linting issues

**Testing Integration**:
- **Follow Test Patterns**: Match existing test file structure and naming
- **Test Coverage**: Write tests for new functionality following existing coverage patterns
- **Integration Tests**: Ensure new feature works with existing features
- **Manual Testing**: Test the feature manually to ensure it works as expected

### **Implementation Guidelines [Medium Priority]**

**File Organization**:
- **Follow Structure**: Place files in same structure as existing similar features
- **Naming Conventions**: Use same naming patterns as rest of codebase
- **Import Organization**: Follow existing import ordering and grouping patterns
- **Export Patterns**: Use same export patterns as existing modules

**Code Patterns**:
- **State Management**: Use existing state management patterns (Redux, Context, etc.)
- **API Calls**: Follow existing API calling patterns and error handling
- **Component Structure**: Match existing component organization and props patterns
- **Styling Approach**: Use same styling methodology (CSS modules, styled-components, etc.)

## Implementation Output

**Code Deliverables**:
- Working feature implementation following existing patterns
- Tests that pass and follow existing test structure
- Integration with existing codebase without breaking changes
- Clean, readable code that matches project style

**Documentation**:
- Code comments where necessary (matching existing comment style)
- Update relevant documentation if feature changes existing behavior
- Include usage examples if feature adds new APIs or components

## Quality Standards

**Code Quality**:
- Follow existing linting rules and code formatting
- Maintain type safety if project uses TypeScript
- Handle errors consistently with existing error handling patterns
- Optimize performance using same optimization patterns as existing code

**Integration Quality**:
- Feature works with existing authentication/authorization
- Maintains existing user experience patterns
- Doesn't break existing functionality
- Follows same accessibility patterns as existing features
- Accessibility compliance score >95%

### **User Metrics**
- Feature adoption rate
- User satisfaction scores
- Error rate <1%
- Support ticket volume minimal

### **Business Metrics**
- Requirements fully implemented
- Delivery timeline met
- Stakeholder approval obtained
- Documentation complete and accessible