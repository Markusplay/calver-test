# CalVer Tagging Setup

This repository implements automatic CalVer (Calendar Versioning) tagging using GitHub Actions.

## Format

Tags follow the format: `yyyy.mm.dd_hh-mm.auto_increment`

Where:
- `yyyy.mm.dd` - Current UTC date
- `hh-mm` - Current UTC time (hours-minutes, hyphen used for git compatibility)
- `auto_increment` - Number that increments for releases on the same day (starts at 0, resets daily)

Note: Hyphens and underscores are used instead of colons due to git tag naming restrictions.

## How it Works

The workflow automatically triggers when a new release is created and:

1. Calculates the current UTC date and time
2. Checks for existing tags from the same day
3. Increments the auto_increment number if there are existing tags from today
4. Creates and pushes the new CalVer tag
5. Links the tag to the release

## Examples

- First release today: `2024.09.28_14-30.0`
- Second release today: `2024.09.28_15-45.1`
- Third release today: `2024.09.28_16-20.2`
- First release tomorrow: `2024.09.29_09-15.0`

## Required Branches

The following branches should be created manually in GitHub:

1. **prod** - Production branch
2. **staging** - Staging branch

To create these branches:
1. Go to the GitHub repository
2. Click on the branch dropdown (currently showing "main" or current branch)
3. Type "prod" and click "Create branch: prod from 'main'"
4. Repeat for "staging"

## Workflow File

The workflow is defined in `.github/workflows/calver-tagging.yml` and will automatically run when you create a release through the GitHub interface.

## Permissions

The workflow has `contents: write` permission to create and push tags to the repository.