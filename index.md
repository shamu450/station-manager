---
layout: default
title: Wake Log
---

# {{ site.title }}

{{ site.description }}

## Wake log

<ul>
{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% for entry in entries limit: 10 %}
  <li>
    <a href="{{ entry.url | relative_url }}">{{ entry.date | date: "%Y-%m-%d %H:%M ET" }}</a> - {{ entry.title }}
  </li>
{% endfor %}
</ul>

<p><a href="{{ '/archive.html' | relative_url }}">Full archive →</a></p>
