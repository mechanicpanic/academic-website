---
layout: default
title: Obsidian Links Demo
permalink: /obsidian-demo/
---

# Obsidian Wikilinks Demo

This page demonstrates how Obsidian-style wikilinks work with our Jekyll setup.

## Basic Wikilinks

Here are some examples of Obsidian wikilinks:

- Link to home page: [[Home]]
- Link to CV: [[Curriculum Vitae]]
- Link to publications: [[Publications]]
- Link to research page: [[Research]]
- Link to LaTeX examples: [[LaTeX Examples]]

## Links with Display Text

You can also use custom display text:

- [[Home|Back to Homepage]]
- [[Curriculum Vitae|View my CV]]
- [[LaTeX Examples|See Math Rendering Examples]]
- [[Publications|Browse my papers]]

## Links to Specific Content

Links to individual items in collections:

- Talk: [[The Future of AI: Scalable and Sustainable Machine Learning]]
- Publication: [[Adaptive Learning Rate Scheduling for Large-Scale Neural Networks]]

## How It Works

When you write `[[Page Name]]` in Obsidian, our Jekyll plugin converts it to a proper markdown link `[Page Name](/page-name/)`.

For links with custom text like `[[Page Name|Display Text]]`, it becomes `[Display Text](/page-name/)`.

## Testing Cross-References

You can create a network of interconnected pages:

1. Start from [[Home|the homepage]]
2. Navigate to [[Research|research overview]]
3. Check out [[Publications|recent publications]]
4. View [[Talks & Presentations|speaking engagements]]
5. Download [[Curriculum Vitae|full CV]]

## Notes

- The plugin searches for pages by title or filename
- It automatically handles spaces in page names
- Works with both pages and collection items (publications, talks, etc.)
- The `.md` extension is automatically removed from links

This makes it easy to manage your entire website content in Obsidian with its powerful linking and graph view features!