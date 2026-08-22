---
layout: default
title: Archive
---

# Full archive

{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% for entry in entries %}
<article>
  <p><a href="{{ entry.url | relative_url }}"><strong>{{ entry.date | date: "%Y-%m-%d %H:%M ET" }}</strong></a></p>
  {{ entry.content }}
</article>
<hr>
{% endfor %}

<p><a href="{{ '/' | relative_url }}">&larr; Back to wake log</a></p>
