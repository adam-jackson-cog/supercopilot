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

## File Creation Framework

**CRITICAL**: Always create actual files in the workspace using file creation tools.

**File Creation Process**:
1. **Use create_file tool** to create new files with content
2. **Use edit_file tool** to modify existing files
3. **Verify file creation** - confirm files exist in workspace
4. **Never create code blocks only** - always create actual files

**File Creation Examples**:
- Create index.html: Use create_file tool with full HTML content
- Create style.css: Use create_file tool with CSS styles
- Create script.js: Use create_file tool with JavaScript code
- Update package.json: Use edit_file tool to modify existing file

## Output Requirements

**Working Prototype**:
- **Files created in workspace** using create_file and edit_file tools
- Functional demonstration of core concept
- Primary user flow implementation
- Basic error handling for demo stability
- Realistic mock data

**File Verification**:
- Confirm all required files exist in workspace
- Verify file contents match requirements
- Test file accessibility and execution
- Document file structure created

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
- **Actual files in workspace** (not code blocks in chat)
- Demo deployment instructions
- Quick setup instructions
- Known limitations documentation
- Next iteration recommendations

## Symbol Legend
- ⚡ Speed optimization opportunity
- 🎨 Visual/UX consideration
- 🔗 Library/tool integration
- 📱 User interaction pattern
- ⏱ Time-saving technique
- 📁 File creation required (use create_file tool)
- ✅ File verification checkpoint
- → Leads to rapid implementation
- ∴ Therefore prioritize for demo
- ⚠ Shortcut taken (document for later)
- 🎯 Prototype success criteria

## Troubleshooting File Creation Issues

**If file creation fails**:
1. Verify create_file and edit_file tools are available
2. Check workspace permissions
3. Try manual file creation if tools fail
4. Document limitation and suggest workaround
5. Use alternative approaches if necessary

**Known Limitations**:
- Custom chat modes may have limited file creation permissions
- Some GitHub Copilot configurations may restrict file operations
- Agent mode may require explicit tool confirmation