---
title: "Migrating from Medium to a Static Blog"
date: 2026-09-01T09:00:00+07:00
draft: false
description: "A practical look at moving from a hosted writing platform to a local-first Hugo blog."
summary: "The reasons to own the source files, the publishing workflow, and the generated output."
home_display: "full"
tags:
  - writing
  - migration
  - static-sites
categories:
  - workflow
---

Moving writing to a static site is less about changing platforms and more about making the publishing process visible and portable.

## Keep the source simple

Each post is a Markdown file. Its title, date, and other metadata live at the top of the file as YAML front matter. The body remains readable even outside the site generator.

## Review locally first

The local Hugo server gives every post a review loop before publication. It makes it easy to check headings, links, images, and the final page layout without depending on a remote service.

## Own the generated result

Hugo produces ordinary HTML, CSS, and assets. That output can remain a local artifact today and be deployed to a static hosting provider later without changing the writing format.
