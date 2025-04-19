---
title: "Book Recommendations"
layout: books
permalink: /books/
classes: wide             # full‑width content area
author_profile: true
---

> Hand‑picked books I keep recommending to friends and colleagues.  
> **Click a title** to view details.

<div style="display: flex; gap: 2rem; margin-top: 2rem;">
  <div class="books-sidebar">
    <input id="bookSearch" type="search" placeholder="Filter books by title..." style="width:100%;padding:0.6rem;margin-bottom:1rem;border-radius:0.5rem;">
    <ul id="bookList" style="font-size: 0.85rem;">
      {% assign sorted_books = site.data.books | sort: "title" %}
      {% for book in sorted_books %}
        <li class="book-item" data-book-id="{{ forloop.index0 }}">{{ book.title }}</li>
      {% endfor %}
    </ul>
  </div>
  
  <div class="books-content">
    <div id="bookDetails">
      <div class="book-placeholder">Choosing a random book...</div>
      {% for book in sorted_books %}
        <div class="book-detail" id="book-{{ forloop.index0 }}" style="display:none;">
          <h2>{{ book.title }}</h2>
          <div class="book-detail-flex">
            <div class="book-image">
              <img src="/{{ book.path | default: 'assets/images/no_cover.png' }}" alt="{{ book.title }}">
            </div>
            <div class="book-info">
              <p>{{ book.description }}</p>
              <a href="{{ book.link }}" class="btn btn--primary" target="_blank">Details on Amazon</a>
            </div>
          </div>
        </div>
      {% endfor %}
    </div>
  </div>
</div>

<style>
  .books-container {
    display: flex;
    gap: 2rem;
    margin-top: 2rem;
  }
  
  .books-sidebar {
    flex: 0 0 300px;
    border-right: 1px solid #eaeaea;
    padding-right: 1rem;
  }
  
  .books-content {
    flex: 1;
  }
  
  #bookList {
    list-style: none;
    padding: 0;
    margin: 0;
    max-height: 600px;
    overflow-y: auto;
  }
  
  .book-item {
    padding: 0.8rem 1rem;
    cursor: pointer;
    border-radius: 4px;
    margin-bottom: 0.5rem;
    transition: background-color 0.2s;
  }
  
  .book-item:hover {
    background-color: #f5f5f5;
  }
  
  .book-item.active {
    background-color: #eef;
    font-weight: bold;
  }
  
  .book-detail-flex {
    display: flex;
    gap: 2rem;
    align-items: flex-start;
  }
  
  .book-image {
    flex: 0 0 200px;
  }
  
  .book-image img {
    max-width: 100%;
    border-radius: 4px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }
  
  .book-info {
    flex: 1;
  }
  
  .book-placeholder {
    text-align: center;
    padding: 3rem;
    color: #666;
    font-style: italic;
    background-color: #f9f9f9;
    border-radius: 8px;
  }
  
  @media (max-width: 768px) {
    .books-container {
      flex-direction: column;
    }
    
    .books-sidebar {
      flex: auto;
      border-right: none;
      border-bottom: 1px solid #eaeaea;
      padding-right: 0;
      padding-bottom: 1rem;
      margin-bottom: 1rem;
    }
    
    .book-detail-flex {
      flex-direction: column;
    }
    
    .book-image {
      margin-bottom: 1rem;
      text-align: center;
    }
  }
</style>

<script>
window.addEventListener('load', function() {
  setTimeout(function() {
    const searchInput = document.getElementById('bookSearch');
    const bookItems = document.querySelectorAll('.book-item');
    const bookDetails = document.querySelectorAll('.book-detail');
    const placeholder = document.querySelector('.book-placeholder');
    
    // Show a random book by default
    if (bookItems.length > 0 && bookDetails.length > 0) {
      // Generate a random index
      const randomIndex = Math.floor(Math.random() * bookItems.length);
      
      // Select the random book
      bookItems[randomIndex].classList.add('active');
      document.getElementById('book-' + randomIndex).style.display = 'block';
      if (placeholder) placeholder.style.display = 'none';
      
      // Scroll the selected book into view in the sidebar
      bookItems[randomIndex].scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    
    // Handle book selection
    bookItems.forEach(function(item) {
      item.addEventListener('click', function() {
        const bookId = this.getAttribute('data-book-id');
        
        // Update active state
        bookItems.forEach(i => i.classList.remove('active'));
        this.classList.add('active');
        
        // Show selected book details
        bookDetails.forEach(detail => detail.style.display = 'none');
        document.getElementById('book-' + bookId).style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
      });
    });
    
    // Filter functionality
    if (searchInput) {
      searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase().trim();
        let firstVisible = null;
        
        bookItems.forEach(function(item) {
          const titleText = item.textContent.toLowerCase();
          const isVisible = titleText.includes(searchTerm);
          item.style.display = isVisible ? 'block' : 'none';
          
          // Track first visible item
          if (isVisible && !firstVisible) {
            firstVisible = item;
          }
        });
        
        // Select first visible book if search is active
        if (searchTerm && firstVisible) {
          firstVisible.click();
        }
      });
    }
  }, 500);
});
</script> 