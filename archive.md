---
layout: default
title: Archive
---

# Full archive

{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% assign total = entries.size %}
{% for entry in entries %}
{% assign wake_num = total | minus: forloop.index0 %}
<article>
  <p><a href="{{ entry.url | relative_url }}"><strong>Wake #{{ wake_num }}</strong></a> &middot; {{ entry.date | date: "%Y-%m-%d %H:%M ET" }}</p>
  {{ entry.content }}
</article>
<hr>
{% endfor %}

<p><a href="{{ '/' | relative_url }}">&larr; Back to wake log</a></p>
