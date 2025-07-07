# Security Analysis Rules (Hybrid)

**Mindset**: "What could go wrong?" - Combine automated scanning with contextual threat assessment.

## Automated Security Checks [Scripts]

**Secret Detection**: `.github/scripts/analyze/security/detect_secrets.py`
- Scans: Hardcoded passwords, API keys, database URLs, JWT secrets, AWS keys, private keys
- Output: JSON report with file locations, line numbers, secret types

**Vulnerability Scanning** (Planned):
- `.github/scripts/analyze/security/scan_vulnerabilities.py` - OWASP Top 10 pattern matching
- `.github/scripts/analyze/security/check_auth.py` - Authentication/session validation
- `.github/scripts/analyze/security/validate_inputs.py` - Injection vulnerability detection

## Contextual Security Assessment [LLM Analysis]

**Business Logic Security**:
- Evaluate authorization rules for privilege escalation risks
- Assess data flow security between components
- Analyze domain-specific attack vectors
- Prioritize based on business impact

**Architecture Security Review**:
- Evaluate security patterns vs threat model
- Assess defense-in-depth implementation
- Review control effectiveness and gaps
- Recommend improvements for compliance

**Risk Assessment**:
- Identify assets, threats, vulnerabilities in context
- Assess breach likelihood and impact
- Evaluate existing controls effectiveness
- Prioritize remediation by risk score

## Analysis Process
1. **Run scripts** to identify measurable security issues
2. **Analyze outputs** in context of business requirements  
3. **Evaluate risks** through architectural review
4. **Prioritize findings** by business impact and exploitability
5. **Generate report** combining automated + contextual analysis

## Risk Assessment
- **CRITICAL**: Data breach, system compromise, compliance violation
- **HIGH**: Privilege escalation, injection, auth bypass
- **MEDIUM**: Information disclosure, DoS, config issues  
- **LOW**: Hardening opportunities, defense gaps

## Output Requirements
- Risk-rated vulnerability report with script outputs
- Contextual analysis with business impact
- Prioritized remediation roadmap
- Implementation guidance and code examples

## Symbol Legend
- 🤖 Automated script analysis
- 🧠 LLM contextual analysis
- 🚨 Critical security flaw requiring immediate attention
- ⚠️ Security concern requiring assessment and remediation
- ✅ Security control properly implemented
- 🔍 Requires deeper investigation and analysis