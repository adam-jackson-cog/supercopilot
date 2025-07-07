# Security Analysis Rules

**Mindset**: "What could go wrong?" - Assume threats exist everywhere, trust must be earned.


## Systematic Security Analysis

### **Authentication & Authorization [Critical]**
**Password Security**:
- Password policies: length, complexity, expiration
- Hashing algorithms: bcrypt, scrypt, argon2 (not MD5/SHA1)
- Salt generation: unique, cryptographically secure

**Session Management**:
- Session timeout configurations
- Secure session storage (HttpOnly, Secure flags)
- Session invalidation on logout
- CSRF protection mechanisms

**Access Control**:
- Role-based access control (RBAC) implementation
- Privilege escalation prevention
- API endpoint authorization checks
- Resource-level permissions

**Token Security**:
- JWT secret management & rotation
- Token expiration policies
- Refresh token security
- Bearer token transmission security

### **Input Validation & Injection [Critical]**
**SQL Injection**:
- Parameterized queries/prepared statements
- ORM usage patterns & escaping
- Dynamic query construction risks
- Database user privilege limitations

**Cross-Site Scripting (XSS)**:
- Input sanitization implementations
- Output encoding strategies
- Content Security Policy (CSP) headers
- DOM manipulation security

**Command Injection**:
- System command execution patterns
- User input in exec/eval functions
- File path validation
- Shell command construction

**File Upload Security**:
- File type validation (not just extensions)
- File size limitations
- Upload directory permissions
- Executable file restrictions

### **Data Protection [High]**
**Sensitive Data Exposure**:
- Credentials in source code
- API keys in client-side code
- Database connection strings
- Log sanitization (no passwords/tokens)

**Encryption Implementation**:
- Data at rest encryption
- Transport layer security (TLS 1.3+)
- Key management practices
- Algorithm selection (AES-256, RSA-2048+)

**Privacy Compliance**:
- PII data handling
- Data retention policies
- GDPR/CCPA compliance patterns
- Data anonymization techniques

### **Infrastructure Security [Medium-High]**
**Configuration Security**:
- Default credentials changed
- Unnecessary services disabled
- Security headers implementation
- Error message sanitization

**Dependency Management**:
- Outdated package detection
- Known vulnerability scanning
- Dependency pinning strategies
- Supply chain security

**Secrets Management**:
- Environment variable usage
- Secret rotation mechanisms
- Vault/HSM integration
- Development vs production secrets

## Analysis Framework

**Risk Assessment Matrix**:
- **CRITICAL**: Data breach, system compromise, compliance violation
- **HIGH**: Privilege escalation, injection vulnerabilities, auth bypass
- **MEDIUM**: Information disclosure, DoS potential, configuration issues  
- **LOW**: Security hardening opportunities, defense-in-depth gaps

**Attack Vector Analysis**:
1. **External Threats**: Internet-facing vulnerabilities
2. **Internal Threats**: Privilege escalation, lateral movement
3. **Supply Chain**: Third-party dependencies, build pipeline
4. **Social Engineering**: Phishing targets, credential reuse

**Business Impact Assessment**:
- Data breach cost estimation
- Compliance fine potential
- Reputation damage risk
- Service availability impact

## Output Requirements

**Vulnerability Report**:
- Risk rating w/ CVSS scoring
- Proof of concept (where safe)
- Business impact description
- Remediation priority ranking

**Remediation Roadmap**:
- Immediate fixes (< 24hrs)
- Short-term improvements (< 1 week)
- Long-term security enhancements (< 1 month)
- Architecture recommendations

**Implementation Guidance**:
- Code examples for fixes
- Configuration templates
- Testing validation steps
- Monitoring/alerting setup

## Symbol Legend
- 🚨 Critical security flaw
- ⚠ Security concern requiring attention  
- ✅ Security control properly implemented
- 🔍 Requires deeper investigation
- 📋 Checklist item to verify
- → Leads to security risk
- ∴ Therefore vulnerable to