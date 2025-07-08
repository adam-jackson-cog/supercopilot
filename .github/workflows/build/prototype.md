# Prototype Build Rules

**Mindset**: "Speed over perfection" - Rapid validation of concepts using existing libraries and mocking.


## Rapid Prototyping Strategy

### **Speed Optimization Techniques [Critical]**

**Existing Library Utilization**:
- **UI Components**: Use pre-built component libraries (Material-UI, Ant Design)
- **Styling**: Utility-first CSS (Tailwind) or CSS-in-JS libraries
- **Icons**: Icon libraries (Heroicons, Feather, FontAwesome)
- **Layout**: CSS Grid/Flexbox frameworks or layout components

**Mock Implementation Patterns**:
- **Data**: Hardcoded objects, faker.js for realistic data
- **APIs**: JSON files, local storage, or json-server
- **Authentication**: Hardcoded user states, localStorage tokens
- **External Services**: Mock responses, placeholder implementations

**Development Shortcuts**:
- **Bundling**: Use CDN links or create-react-app defaults
- **Styling**: Inline styles acceptable, CSS modules for organization
- **State**: Simple useState/reactive patterns, avoid complex state management
- **Routing**: Hash-based routing or simple conditional rendering

**Time-Saving Patterns**:
- **Copy-Paste**: Leverage existing code examples & snippets
- **Code Generation**: Use CLI tools for quick scaffolding
- **Template Libraries**: Start from pre-built templates
- **AI Assistance**: Use code generation for repetitive patterns

### **Implementation Focus Areas [High Priority]**

**Core User Flow**:
- Primary user journey (happy path)
- Key interaction points
- Essential feature demonstrations
- User decision points

**Visual Design Priority**:
- Layout structure & information hierarchy
- Color scheme & branding alignment
- Typography & readability
- Responsive behavior basics

**Interaction Patterns**:
- Button clicks & form submissions
- Navigation between screens
- Data display & filtering
- Loading states & feedback

**Demo Preparation**:
- Realistic but fake data
- Clear call-to-action elements
- Error state handling (basic)
- Success feedback mechanisms

### **Acceptable Shortcuts [Medium Priority]**

**Code Quality Compromises**:
- Inline styles for speed
- Hardcoded values instead of constants
- Copy-paste code blocks
- Minimal error handling

**Architecture Simplifications**:
- Single file components
- No separation of concerns
- Direct DOM manipulation if needed
- Minimal abstraction layers

**Security Omissions** (prototype only):
- Mock authentication flows
- Hardcoded API keys (development only)
- No input validation
- No data sanitization

**Performance Postponements**:
- No optimization (lazy loading, memoization)
- Large bundle sizes acceptable
- Synchronous operations
- No caching strategies

### **Explicit Non-Requirements [Low Priority]**

**Testing Exclusions**:
- No unit tests required
- No integration testing
- No E2E testing
- No test coverage targets

**Production Concerns**:
- No security hardening
- No performance optimization
- No scalability considerations
- No monitoring/logging

**Documentation Minimums**:
- No comprehensive documentation
- Minimal code comments
- No API documentation
- Basic README only

## Prototyping Framework

**Time Allocation**:
- **Setup & Research** (20%): Tool selection, quick research
- **Core Implementation** (60%): Primary features & UI
- **Polish & Demo Prep** (20%): Visual improvements, demo readiness

**Success Criteria**:
- **Functional Demo**: Core user flow works end-to-end
- **Visual Appeal**: Looks professional enough for feedback
- **Time Efficiency**: Completed within time constraints
- **User Testable**: Ready for user feedback collection

**Quality Checkpoints**:
- Does it demonstrate the core concept?
- Can users understand the intended flow?
- Is it visually appealing enough for presentation?
- Are the key interactions working?

## Output Requirements

**Working Prototype**:
- Functional demonstration of core concept
- Primary user flow implementation
- Basic error handling for demo stability
- Realistic mock data

**Time Efficiency**:
- Target: 1-4 hours for basic prototype
- Maximum: 1 day for complex prototypes
- Focus on speed over perfection
- Leverage existing tools & libraries

**User Testing Ready**:
- Clear value proposition demonstration
- Intuitive user interface
- Realistic interaction patterns
- Feedback collection mechanisms

**Handoff Artifacts**:
- Demo deployment link
- Quick setup instructions
- Known limitations documentation
- Next iteration recommendations

## Symbol Legend
- ⚡ Speed optimization opportunity
- 🎨 Visual/UX consideration
- 🔗 Library/tool integration
- 📱 User interaction pattern
- ⏱ Time-saving technique
- → Leads to rapid implementation
- ∴ Therefore prioritize for demo
- ⚠ Shortcut taken (document for later)
- 🎯 Prototype success criteria