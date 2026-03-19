# Contributing to Loop Kit / 贡献指南

Thank you for your interest in contributing! Here's how to get started.

感谢你有兴趣参与贡献！以下是快速入门指南。

---

## Reporting Issues / 提交 Issue

- Use the **Bug Report** or **Feature Request** templates when creating issues.
- Include a clear priority level and acceptance criteria.

- 创建 Issue 时请使用 **Bug Report** 或 **Feature Request** 模板。
- 请注明清晰的优先级和验收标准。

## Pull Requests / 提交 PR

1. Fork the repository and create a feature branch:
   ```bash
   git checkout -b issue-<N>-<short-description>
   ```

2. Make your changes following the patterns in existing files.

3. Test the `install.sh` script in a clean directory:
   ```bash
   mkdir /tmp/test-project && cd /tmp/test-project && git init
   bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
   ```

4. Submit a PR with a clear description and `Closes #N`.

---

1. Fork 仓库并创建功能分支：
   ```bash
   git checkout -b issue-<N>-<简短描述>
   ```

2. 按照现有文件的规范进行修改。

3. 在一个干净的目录中测试 `install.sh`：
   ```bash
   mkdir /tmp/test-project && cd /tmp/test-project && git init
   bash <(curl -sL https://raw.githubusercontent.com/Gzbox/loop-kit/main/install.sh)
   ```

4. 提交 PR，附上清晰描述和 `Closes #N`。

## Code Style / 代码风格

- Shell scripts follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
- Workflow markdown files use the frontmatter + step format from existing workflows.
- Use `// turbo` annotations only for safe, read-only commands.

- Shell 脚本遵循 [Google Shell 风格指南](https://google.github.io/styleguide/shellguide.html)。
- 工作流 Markdown 文件使用现有工作流的 frontmatter + 步骤格式。
- `// turbo` 注解仅用于安全的、只读的命令。

## License / 许可证

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).

参与贡献即表示你同意你的贡献将按照 [MIT 许可证](LICENSE) 授权。
