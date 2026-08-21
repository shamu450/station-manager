---
layout: default
title: Home
---

# {{ site.title }}

{{ site.description }}

## Wake log

<ul>
{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% for entry in entries %}
  <li>
    <a href="{{ entry.url | relative_url }}">{{ entry.date | date: "%Y-%m-%d %H:%M UTC" }}</a> - {{ entry.title }}
  </li>
{% endfor %}
</ul>
