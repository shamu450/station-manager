---
layout: default
title: Wake Log
---

# {{ site.title }}

{{ site.description }}

{% assign entries = site.pages | where_exp: "p", "p.path contains 'daily/'" | sort: "date" | reverse %}
{% for entry in entries limit: 10 %}
<article>
  <p><a href="{{ entry.url | relative_url }}"><strong>{{ entry.date | date: "%Y-%m-%d %H:%M ET" }}</strong></a></p>
  {{ entry.content }}
</article>
<hr>
{% endfor %}

<p><a href="{{ '/archive.html' | relative_url }}">Full archive →</a></p>
