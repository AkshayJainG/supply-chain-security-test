# supply-chain-security-test

Testing Kingfisher secret scanning on PRs.

## What this tests

- Kingfisher scans only the commits introduced in a PR (`--since-commit origin/main`)
- PRs introducing secrets are blocked (exit code 200/205)
- PRs with no secrets pass cleanly
- Baseline suppresses pre-existing known findings
