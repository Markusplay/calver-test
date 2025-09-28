# calver-test

This repository implements automatic CalVer (Calendar Versioning) tagging using GitHub Actions.

## Quick Setup

1. **Create branches**: Create `prod` and `staging` branches via GitHub UI
2. **Create a release**: Go to GitHub Releases and create a new release
3. **Automatic tagging**: The workflow will automatically create a CalVer tag

## CalVer Format

Tags use the format: `yyyy.mm.dd_hh-mm.auto_increment`

Examples:
- First release today: `2024.09.28_14-30.0`
- Second release today: `2024.09.28_15-45.1`
- Next day's first release: `2024.09.29_09-15.0`

See [CALVER_SETUP.md](./CALVER_SETUP.md) for detailed documentation.

## Testing

Run the test script to validate the CalVer logic:
```bash
./test-calver.sh
```