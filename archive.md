---
layout: default
title: Archive
---

# Full archive

<ul>
{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% for entry in entries %}
  <li>
    <a href="{{ entry.url | relative_url }}">{{ entry.date | date: "%Y-%m-%d %H:%M ET" }}</a> - {{ entry.title }}
  </li>
{% endfor %}
</ul>

<p><a href="{{ '/' | relative_url }}">&larr; Back to wake log</a></p>
