---
layout: books
title: Testing Books
permalink: /books/
---

A curated collection of essential books for software testing professionals. These books cover various aspects of testing, from unit testing to continuous delivery, helping you master the art and science of software testing.

0 · Outcome
URL – /books/

Look – Pinterest‑style grid of cover‑cards (thumbnail + title + short blurb + button).

Maintenance – to add a book you only edit _data/books.json and commit the cover image; nothing else.

1 · Prerequisites

Item	Value
Branch name	feature/books-page
Serve	JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml
Build	JEKYLL_ENV=production bundle exec jekyll build
Theme	Minimal Mistakes ≥ 4.25 (for feature_row cards)
2 · Step‑by‑step
### 2‑1 Create the feature branch

bash
Copy
Edit
git checkout -b feature/books-page
### 2‑2 Store the data

Create _data/books.json and paste the full JSON array you supplied.

Keep exact keys: title, link, path, description.

Tip: if a cover is missing just leave "path": null – the template hides the image gracefully.

### 2‑3 Add the cover art

Copy every JPG/PNG into assets/images/books/ (or keep your downloaded_covers/ folder if you prefer).

Paths in JSON should be root‑relative at build time, e.g.

json
Copy
Edit
"path": "assets/images/books/Clean_Code.jpg"
### 2‑4 Wire navigation

Edit _data/navigation.yml (or your site‑wide nav file) and insert:

yaml
Copy
Edit
  - title: "Books"
    url: /books/
### 2‑5 Create books/index.md

markdown
Copy
Edit
---
title: "Book Recommendations"
layout: page
permalink: /books/
classes: wide             # full‑width content area
author_profile: true
---

> Hand‑picked books I keep recommending to friends and colleagues.  
> **Click a card** to learn more or grab a copy.

<!-- --------------- FILTER INPUT (optional) --------------- -->
<input id="bookSearch" type="search" placeholder="Filter books…" style="width:100%;padding:0.6rem;margin-bottom:1rem;border-radius:0.5rem;">

<!-- --------------- LIQUID: build the card data --------------- -->
{% assign books = site.data.books %}
{% capture cards %}
{% for b in books %}
  - image_path: {{ b.imagePath | default: '/assets/images/no_cover.png' }}
    alt: "{{ b.title | escape }}"
    title: "{{ b.title | escape }}"
    excerpt: "{{ b.description | strip_newlines | truncate: 120 }}"
    url: "{{ b.link }}"
    btn_label: "View"
    btn_class: "btn--primary"
    # custom attribute for JS filtering
    categories: "{{ b.title | downcase }} {{ b.description | downcase }}"
{% endfor %}
{% endcapture %}
{% assign book_cards = cards | yaml_to_liquid %}

<!-- --------------- RENDER --------------- -->
{% include feature_row
     type="card"
     id="books"
     items=book_cards
%}

<!-- --------------- QUICK CLIENT‑SIDE FILTER --------------- -->
<script>
const q = document.getElementById('bookSearch');
if (q) {
  q.addEventListener('input', e => {
    const term = e.target.value.toLowerCase();
    document.querySelectorAll('#books .feature__item').forEach(card => {
      const haystack = card.dataset.categories || '';
      card.style.display = haystack.includes(term) ? '' : 'none';
    });
  });
}
</script>
What happens?

We pull everything from _data/books.json.

A tiny Liquid loop turns each book into a feature_row card (no custom CSS needed).

The search input toggles cards client‑side in ~15 lines of plain JS.

Cards flow in a multi‑column grid on desktop and stack nicely on mobile.

### 2‑6 Smoke‑test locally

bash
Copy
Edit
JEKYLL_ENV=development bundle exec jekyll serve --config _config.yml,_config.development.yml
# then open http://localhost:4000/books/
Check:

Covers, titles, blurbs, and "View" buttons render.

Filtering hides/shows cards instantly.

Navigation link works.

### 2‑7 Commit & push

bash
Copy
Edit
git add _data/books.json assets/images/books/ books/index.md _data/navigation.yml
git commit -m "feat: add single‑page Book Recommendations gallery"
git push -u origin feature/books-page
Open a pull‑request; merge once CI passes.

3 · Adding more books later
Drop the cover into assets/images/books/.

Append an object to _data/books.json:

jsonc
Copy
Edit
{
  "title": "New Book",
  "link": "https://amzn.to/xyz",
  "path": "assets/images/books/New_Book.jpg",
  "description": "One‑sentence pitch."
}
Commit & deploy. Done—no template edits required.

4 · Rollback (if needed)
bash
Copy
Edit
git checkout main
git branch -D feature/books-page
git push origin --delete feature/books-page
Nothing permanent touches layout or plugins.

### All set 📚🚀

You now have a self‑contained, data‑driven Books page that scales from a handful to hundreds of titles with zero extra markup—just JSON entries and images. Enjoy!