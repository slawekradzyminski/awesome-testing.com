0 · What we’re building
/talks/ – a standalone page that shows all videos side‑by‑side as clickable cards (thumbnail + title + “Watch” button).

Uses Minimal Mistakes’ built‑in feature_row include, so no CSS hacking.

Works for any future videos—just append an item to a YAML list inside the same file.

1 · Prerequisites

Item	Value
Branch name	feature/talks-single-page
Serve	JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml
Build	JEKYLL_ENV=production bundle exec jekyll build
2 · Step‑by‑step
2‑1 Create the branch
bash
Copy
Edit
git checkout -b feature/talks-single-page
2‑2 Add navigation
Open _data/navigation.yml, and insert (or move) the entry:

yaml
Copy
Edit
  - title: "Talks"
    url: /talks/
2‑3 Create the page file
Make talks/index.md (directory+file—do not name it .html, Markdown is easier):

markdown
Copy
Edit
---
title: "Conference & Meetup Talks"
layout: page          # wide layout with sidebar & masthead
permalink: /talks/
classes: wide
author_profile: true
sidebar:              # remove sidebar if you prefer full‑width
  nav: main
---

> Recordings of my recent conference and meetup presentations.  
> Click a card to watch the video on YouTube.

<!-- ----------  CARD DATA  ---------- -->
{% assign talks =  site.data.talks | default: null %}
{% unless talks %}
{% assign talks =  "" | split: "" %}   <!-- ensure array exists -->
{% capture _seed %}
- id: i5owU7RdC9g
  title: "[2023] Effective ChatGPT usage: start with understanding"
  language: English
- id: U8iCGim-ro0
  title: "[2023] Prompt engineering – the Future of Testing?"
  language: Polish
{% endcapture %}
{% assign talks = _seed | yaml_to_liquid %}
{% endunless %}
{% assign grid = "" | split: "" %}
{% for t in talks %}
  {% assign img = "https://img.youtube.com/vi/" | append: t.id | append: "/hqdefault.jpg" %}
  {% capture card %}
    - image_path: {{ img }}
      alt: "{{ t.title | escape }}"
      title: "{{ t.title | escape }}"
      url: "https://www.youtube.com/watch?v={{ t.id }}"
      btn_label: "Watch"
      btn_class: "btn--primary"
  {% endcapture %}
  {% assign grid = grid | push: card %}
{% endfor %}
{% capture feature_yaml %}{{ grid | join: "" }}{% endcapture %}
{% assign feature_row = feature_yaml | yaml_to_liquid %}
<!-- ----------  RENDER CARDS  ---------- -->
{% include feature_row id="feature_row" type="card" %}
### What that does

Builds a YAML array in‑place (talks) – easy to extend later.

For each item, generates a card with the YouTube thumbnail.

feature_row’s type="card" gives a responsive grid that collapses nicely on mobile.

2‑4 Smoke‑test locally
bash
Copy
Edit
JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml
Open http://localhost:4000/talks/ and verify:

Two cards appear with titles and “Watch” buttons.

Clicking a card opens YouTube in a new tab.

Mast‑head “Talks” works.

Search for “ChatGPT” still finds /talks/ because the titles are in the page.

2‑5 Commit & push
bash
Copy
Edit
git add .
git commit -m "feat: add single-page Talks section with card grid"
git push -u origin feature/talks-single-page
Open a PR and merge after CI builds successfully.

3 · Adding more talks later
Edit talks/index.md.

Find the seeded YAML block (_seed).

Append a new list item:

yaml
Copy
Edit
- id: NEW_YOUTUBE_ID
  title: "[2025] Awesome keynote title"
  language: English
Save, commit, deploy—done.

4 · Rollback
bash
Copy
Edit
git checkout main
git branch -D feature/talks-single-page
git push origin --delete feature/talks-single-page
Nothing in the build pipeline or config is permanently altered.

Finished 🚀
You now have a tidy, maintainable Talks page that scales from two videos to dozens with only one file to edit.

Talks to include
[
  {
    "id": "i5owU7RdC9g",
    "title": "[2023] Effective ChatGPT usage: start with understanding",
    "url": "https://www.youtube.com/watch?v=i5owU7RdC9g",
    "language": "English"
  },
  {
    "id": "U8iCGim-ro0",
    "title": "[2023] Prompt engineering - the Future of Testing?",
    "url": "https://www.youtube.com/watch?v=U8iCGim-ro0",
    "language": "Polish"
  }
] 