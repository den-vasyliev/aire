# Contributing to AIRE

Thank you for your interest in contributing to AIRE! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct (coming soon). We expect all contributors to help maintain a respectful, inclusive, and collaborative environment.

## How to Contribute

There are many ways to contribute to AIRE:

1. **Report Bugs**
   - Use the GitHub Issues tracker
   - Clearly describe the issue including steps to reproduce
   - Include relevant information like OS, environment, etc.

2. **Suggest Enhancements**
   - Use GitHub Issues for feature requests
   - Clearly describe the feature and its use case
   - If possible, outline a technical approach

3. **Submit Code Changes**
   - Fork the repository
   - Create a new branch for your feature/fix
   - Write clear, commented code
   - Include tests where applicable
   - Submit a Pull Request

4. **Improve Documentation**
   - Fix typos or clarify existing documentation
   - Add examples and use cases
   - Translate documentation

## Development Process

1. **Fork & Clone**
   ```bash
   git clone https://github.com/your-username/aire.git
   cd aire
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Changes**
   - Write your code
   - Add tests
   - Update documentation

4. **Commit Changes**
   - Use clear commit messages
   - Reference relevant issues
   ```bash
   git commit -m "feat: add new feature #IssueNumber"
   ```

5. **Submit Pull Request**
   - Push to your fork
   - Submit a PR to the main repository
   - Respond to review comments

## Pull Request Guidelines

- Follow the project's coding style and conventions
- Include tests for new features
- Update documentation as needed
- One feature/fix per PR
- Keep PRs focused and manageable in size

## Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/). Each commit message should be structured as follows:

```
<type>(<optional scope>): <description>

[optional body]

[optional footer]
```

### Types
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that don't affect the code's meaning (white-space, formatting, etc)
- `refactor`: Code changes that neither fix a bug nor add a feature
- `perf`: Code changes that improve performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to build process or auxiliary tools

### Examples:
```bash
feat(auth): add JWT authentication
fix(api): handle null response from user service
docs(readme): update installation instructions
test(login): add unit tests for login validation
```

### Breaking Changes
For commits that introduce breaking changes, add `BREAKING CHANGE:` in the footer:

```
feat(api): change authentication endpoint path

BREAKING CHANGE: Authentication endpoint moved from /auth to /v2/auth
``` 