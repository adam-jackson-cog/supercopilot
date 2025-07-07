# Verbose Logging Rules

**Mindset**: "If you can't see it, you can't fix it" - Add comprehensive logging for better observability.

## Logging Enhancement Strategy

**Diagnostic Logging**
- Add detailed logging at key decision points and state transitions
- Log input parameters, intermediate values, and output results
- Include timing information for performance-sensitive operations
- Capture error conditions with full context and stack traces

**Structured Logging**
- Use consistent log formats with structured data (JSON, key-value pairs)
- Include correlation IDs for tracing requests across services
- Add contextual metadata (user ID, session, transaction ID)
- Use appropriate log levels (DEBUG, INFO, WARN, ERROR, FATAL)

**Strategic Placement**
- Log at function entry/exit points for complex operations
- Add logging around external API calls and database operations
- Log state changes and important business logic decisions
- Include logging for retry mechanisms and fallback logic

**Production Considerations**
- Ensure logging doesn't impact performance significantly
- Avoid logging sensitive information (passwords, tokens, PII)
- Use appropriate log levels to control verbosity in production
- Consider log rotation and storage implications