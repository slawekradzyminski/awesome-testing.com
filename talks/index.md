---
title: "Conference & Meetup Talks"
layout: single
permalink: /talks/
classes: wide
author_profile: true
---

> Recordings of my recent conference and meetup presentations.  
> Watch the videos directly on this page or click to view on YouTube.

<style>
.video-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 2rem;
  margin: 2rem 0;
}

.video-card {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 1.5rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.video-title {
  font-size: 1.5em;
  margin: 1rem 0;
  color: #333;
}

.video-meta {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  margin-bottom: 1rem;
  font-size: 1.1em;
}

.video-wrapper {
  position: relative;
  padding-bottom: 56.25%; /* 16:9 aspect ratio */
  height: 0;
  overflow: hidden;
  max-width: 100%;
}

.video-wrapper iframe {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
</style>

<div class="video-grid">
  <div class="video-card">
    <div class="video-meta">
      <span>🇬🇧 English</span>
    </div>
    <div class="video-wrapper">
      {% include video id="i5owU7RdC9g" provider="youtube" %}
    </div>
    <h2 class="video-title">[2023] Effective ChatGPT usage: start with understanding</h2>
  </div>

  <div class="video-card">
    <div class="video-meta">
      <span>🇵🇱 Polish</span>
    </div>
    <div class="video-wrapper">
      {% include video id="U8iCGim-ro0" provider="youtube" %}
    </div>
    <h2 class="video-title">[2023] Prompt engineering – the Future of Testing?</h2>
  </div>
</div> 