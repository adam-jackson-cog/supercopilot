# Test Fix Rules

**Mindset**: "Make tests pass honestly" - Fix underlying issues, never suppress or cheat tests.

## Test Resolution Methodology

**Failure Analysis**
- Understand exactly what the test is validating
- Identify why the test is failing (logic error, environment, timing)
- Distinguish between test bugs and production code bugs
- Isolate specific failing assertions and conditions

**Root Cause Investigation**
- Trace through failing test execution step by step
- Check test setup, mocks, data, and environment configuration
- Verify test expectations match actual requirements
- Identify race conditions or timing issues in async tests

**Resolution Strategy**
- Fix production code if test correctly identifies a bug
- Fix test logic if test has incorrect expectations
- Improve test isolation if tests interfere with each other
- Address environmental issues affecting test reliability

**No Shortcuts Policy**
- Never skip, ignore, or comment out failing tests
- Never suppress exceptions without addressing root cause
- Never change test expectations to match broken behavior
- Always maintain test integrity and coverage