# TDD Build Rules

**Mindset**: "Test first, code second" - Rigorous test-driven development with framework best practices.


## Systematic TDD Implementation

### **Red-Green-Refactor Cycle [Critical]**

**Red Phase - Failing Test**:
- Write test for single, specific behavior
- Test should fail for right reason (not due to syntax errors)
- Verify test fails as expected
- Test describes intended behavior clearly

**Green Phase - Minimal Implementation**:
- Write simplest code to make test pass
- No premature optimization or over-engineering
- Focus solely on making current test green
- Verify all existing tests still pass

**Refactor Phase - Code Improvement**:
- Improve code structure without changing behavior
- Extract common patterns & eliminate duplication
- Improve naming & readability
- Ensure all tests remain green

**Cycle Discipline**:
- Never write production code without failing test
- Never write more test than needed for current behavior
- Never write more production code than needed to pass test

### **Testing Strategy Framework [High Priority]**

**Test Levels & Responsibilities**:
- **Unit Tests**: Single function/method behavior (80% of tests)
- **Integration Tests**: Component interaction (15% of tests)
- **E2E Tests**: Complete user workflows (5% of tests)
- **Contract Tests**: API/interface compliance

**Test Categories by Type**:
- **Behavior Tests**: What the code should do
- **Edge Case Tests**: Boundary conditions & error scenarios
- **Performance Tests**: Response time & resource usage
- **Security Tests**: Input validation & authorization

**Framework-Specific Patterns**:
- **React**: Component rendering, event handling, hook behavior
- **Vue**: Component reactivity, lifecycle, composition API
- **Node.js/Express**: Route handling, middleware, error responses
- **Database**: Query results, transaction behavior, constraints

**Test Data Management**:
- **Fixtures**: Consistent test data across tests
- **Factories**: Dynamic test data generation
- **Builders**: Fluent test data construction
- **Seeds**: Database state management

### **Test Design Principles [Critical]**

**Test Structure Standards**:
- **Arrange**: Set up test conditions & dependencies
- **Act**: Execute the behavior being tested
- **Assert**: Verify expected outcomes
- **Cleanup**: Reset state for next test

**Test Naming Conventions**:
- Descriptive test names explaining behavior
- Pattern: `should_[expected_behavior]_when_[condition]`
- Example: `should_return_user_profile_when_valid_token_provided`
- Avoid technical implementation details in names

**Test Isolation Requirements**:
- Each test independent of others
- No shared mutable state between tests
- Proper setup/teardown for each test
- Tests can run in any order

**Mock & Stub Strategy**:
- Mock external dependencies (APIs, databases, file system)
- Stub unpredictable behavior (time, random values)
- Test doubles for expensive operations
- Verify interactions with mocked dependencies

### **Coverage & Quality Standards [High Priority]**

**Coverage Requirements**:
- **Business Logic**: 100% line coverage required
- **API Endpoints**: All paths & status codes tested
- **Error Handling**: All error scenarios covered
- **Edge Cases**: Boundary conditions & invalid inputs

**Quality Metrics**:
- **Test Readability**: Tests self-documenting & clear
- **Test Speed**: Unit tests < 10ms, integration tests < 100ms
- **Test Reliability**: No flaky tests, consistent results
- **Test Maintainability**: Easy to update when requirements change

**Advanced Testing Techniques**:
- **Property-Based Testing**: Generate test cases automatically
- **Mutation Testing**: Verify test suite quality
- **Snapshot Testing**: UI component regression prevention
- **Visual Regression Testing**: UI appearance consistency

**Continuous Integration**:
- Tests run on every commit
- Coverage reporting & tracking
- Test result notifications
- Performance benchmark tracking

### **TDD Documentation Standards [Medium Priority]**

**Test Documentation**:
- Test descriptions explain business value
- Complex test setup documented
- Test data factories documented
- Mock strategy explanations

**Behavior Documentation**:
- Tests serve as living documentation
- Examples of expected usage patterns
- Error condition documentation
- Performance expectations

**Refactoring Safety**:
- Comprehensive test coverage enables confident refactoring
- Tests verify behavior preservation
- Regression prevention through automation
- Safe code evolution practices

## TDD Development Framework

**Development Rhythm**:
1. **Define Behavior** (5%): Understand what should happen
2. **Write Test** (20%): Capture behavior in failing test
3. **Implement** (60%): Write minimal code to pass
4. **Refactor** (15%): Improve code quality while keeping tests green

**Quality Gates**:
- **Test First**: No production code without failing test
- **Green State**: All tests passing before proceeding
- **Refactor Safety**: Tests protect against regressions
- **Coverage Gate**: Required coverage thresholds met

**Success Indicators**:
- **High Confidence**: Can refactor without fear
- **Fast Feedback**: Quick test execution & failure reporting
- **Living Documentation**: Tests explain system behavior
- **Regression Prevention**: Bugs caught immediately

## Output Requirements

**Comprehensive Test Suite**:
- Tests written before implementation
- 100% coverage of business logic
- All edge cases & error scenarios covered
- Performance tests for critical paths

**Production-Ready Code**:
- Code that passes all tests
- Clean, refactored implementation
- No dead code or unused functionality
- Optimal performance characteristics

**Documentation Artifacts**:
- Test reports with coverage metrics
- Performance benchmark results
- Test suite execution results
- Behavior documentation through tests

**Maintainable Codebase**:
- Easy to modify with test protection
- Clear separation of concerns
- Consistent patterns & conventions
- Sustainable development velocity

## Symbol Legend
- 🔴 Red phase - failing test
- 🟢 Green phase - passing test
- 🔵 Refactor phase - code improvement
- 🧪 Test implementation required
- 📊 Coverage measurement needed
- → Leads to test-driven implementation
- ∴ Therefore behavior is verified
- ⚠ Test complexity warning
- 🎯 TDD success criteria
- ✅ Quality gate passed