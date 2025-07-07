#!/usr/bin/env python3
"""
Demo script: Run all analysis scripts and combine results.
Demonstrates the complete hybrid workflow system.
"""

import os
import sys
import json
import time
from pathlib import Path
from typing import List, Dict, Any

# Add utils to path for imports
script_dir = Path(__file__).parent
sys.path.insert(0, str(script_dir / "utils"))

from output_formatter import ResultFormatter
from cross_platform import CommandExecutor, PathUtils

class AnalysisRunner:
    """Run all analysis scripts and combine results."""
    
    def __init__(self):
        self.script_dir = PathUtils.get_analyze_script_dir()
        self.scripts = {
            "security": "security/detect_secrets.py",
            "performance": "performance/profile_database.py", 
            "code_quality": "code_quality/complexity_metrics.py",
            "architecture": "architecture/coupling_analysis.py"
        }
    
    def run_script(self, script_name: str, target_path: str, summary_mode: bool = True) -> Dict[str, Any]:
        """Run a single analysis script."""
        script_path = Path(self.script_dir) / self.scripts[script_name]
        
        print(f"🔄 Running {script_name} analysis...", file=sys.stderr)
        
        args = [str(script_path), target_path]
        if summary_mode:
            args.append("--summary")
        
        start_time = time.time()
        returncode, stdout, stderr = CommandExecutor.run_python_script(str(script_path), args[1:])
        duration = time.time() - start_time
        
        if returncode == 0:
            try:
                result = json.loads(stdout)
                result["runner_duration"] = round(duration, 3)
                print(f"✅ {script_name} completed in {duration:.3f}s", file=sys.stderr)
                return result
            except json.JSONDecodeError as e:
                print(f"❌ {script_name} - JSON decode error: {e}", file=sys.stderr)
                return {"error": f"JSON decode error: {e}", "stderr": stderr}
        else:
            print(f"❌ {script_name} failed: {stderr}", file=sys.stderr)
            return {"error": f"Script failed (code {returncode})", "stderr": stderr}
    
    def run_all_analyses(self, target_path: str, summary_mode: bool = True) -> Dict[str, Any]:
        """Run all analysis scripts and combine results."""
        print("🚀 SuperCopilot Hybrid Analysis - Running All Scripts", file=sys.stderr)
        print("=" * 60, file=sys.stderr)
        
        start_time = time.time()
        results = {}
        
        for script_name in self.scripts.keys():
            results[script_name] = self.run_script(script_name, target_path, summary_mode)
        
        total_duration = time.time() - start_time
        
        # Generate combined report
        combined_report = self.generate_combined_report(results, target_path, total_duration)
        
        print(f"\n🎉 All analyses completed in {total_duration:.3f}s", file=sys.stderr)
        
        return combined_report
    
    def generate_combined_report(self, results: Dict[str, Any], target_path: str, total_duration: float) -> Dict[str, Any]:
        """Generate a combined analysis report."""
        report = {
            "combined_analysis": {
                "target_path": target_path,
                "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
                "total_duration": round(total_duration, 3),
                "scripts_run": len(self.scripts),
                "summary_mode": True,
                "overall_success": all(not result.get("error") for result in results.values())
            },
            "executive_summary": self.generate_executive_summary(results),
            "detailed_results": results
        }
        
        return report
    
    def generate_executive_summary(self, results: Dict[str, Any]) -> Dict[str, Any]:
        """Generate executive summary of all findings."""
        summary = {
            "total_findings": 0,
            "by_severity": {"critical": 0, "high": 0, "medium": 0, "low": 0, "info": 0},
            "by_category": {},
            "top_issues": [],
            "recommendations": []
        }
        
        # Aggregate findings
        for script_name, result in results.items():
            if result.get("error"):
                continue
                
            script_summary = result.get("summary", {})
            findings = result.get("findings", [])
            
            # Add to totals
            for severity, count in script_summary.items():
                if severity in summary["by_severity"]:
                    summary["by_severity"][severity] += count
                    summary["total_findings"] += count
            
            # Track by category
            summary["by_category"][script_name] = {
                "total": len(findings),
                "summary": script_summary
            }
            
            # Collect critical/high issues for top issues
            for finding in findings:
                if finding.get("severity") in ["critical", "high"]:
                    summary["top_issues"].append({
                        "category": script_name,
                        "title": finding.get("title", ""),
                        "severity": finding.get("severity", ""),
                        "file": finding.get("file_path", ""),
                        "line": finding.get("line_number")
                    })
        
        # Sort top issues by severity
        severity_order = {"critical": 0, "high": 1, "medium": 2, "low": 3, "info": 4}
        summary["top_issues"].sort(key=lambda x: severity_order.get(x["severity"], 5))
        
        # Limit top issues to 20
        summary["top_issues"] = summary["top_issues"][:20]
        
        # Generate recommendations
        summary["recommendations"] = self.generate_recommendations(summary)
        
        return summary
    
    def generate_recommendations(self, summary: Dict[str, Any]) -> List[str]:
        """Generate high-level recommendations based on findings."""
        recommendations = []
        
        # Security recommendations
        security_critical = summary["by_category"].get("security", {}).get("summary", {}).get("critical", 0)
        if security_critical > 0:
            recommendations.append(f"🚨 URGENT: Address {security_critical} critical security issues immediately")
        
        # Performance recommendations  
        perf_high = summary["by_category"].get("performance", {}).get("summary", {}).get("high", 0)
        if perf_high > 5:
            recommendations.append(f"⚡ HIGH: Optimize {perf_high} performance bottlenecks affecting user experience")
        
        # Code quality recommendations
        quality_total = summary["by_category"].get("code_quality", {}).get("total", 0)
        if quality_total > 1000:
            recommendations.append(f"🏗 MEDIUM: Address code quality issues to improve maintainability ({quality_total} findings)")
        
        # Architecture recommendations
        arch_high = summary["by_category"].get("architecture", {}).get("summary", {}).get("high", 0)
        if arch_high > 0:
            recommendations.append(f"🔗 MEDIUM: Resolve {arch_high} high-coupling architectural issues")
        
        if not recommendations:
            recommendations.append("✅ Overall code health appears good - continue with regular monitoring")
        
        return recommendations

def main():
    """Main function for command-line usage."""
    if len(sys.argv) < 2 or len(sys.argv) > 3:
        print("Usage: python run_all_analysis.py <target_path> [--verbose]")
        print("  --verbose: Include detailed results (default is summary mode)")
        sys.exit(1)
    
    target_path = sys.argv[1]
    summary_mode = not (len(sys.argv) == 3 and sys.argv[2] == "--verbose")
    
    runner = AnalysisRunner()
    report = runner.run_all_analyses(target_path, summary_mode)
    
    # Output combined report
    print(json.dumps(report, indent=2))

if __name__ == "__main__":
    main()