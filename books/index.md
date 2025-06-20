---
title: "Book Recommendations"
layout: books
permalink: /books/
classes: wide             # full‑width content area
author_profile: true
---

> Hand‑picked books I recommend to friends and colleagues.  
> A new random book is displayed each time you visit.

<div style="display: flex; gap: 2rem; margin-top: 2rem;">
  <div class="books-sidebar mobile-collapsed">
    <input id="bookSearch" type="search" placeholder="Filter books by title..." style="width:100%;padding:0.6rem;margin-bottom:1rem;border-radius:0.5rem;">
    <ul id="bookList" style="font-size: 0.85rem;">
      {% assign sorted_books = site.data.books | sort: "title" %}
      {% for book in sorted_books %}
        <li class="book-item" data-book-id="{{ forloop.index0 }}" data-book-slug="{{ book.title | slugify }}">{{ book.title }}</li>
      {% endfor %}
    </ul>
  </div>
  
  <div class="books-content">
    <div id="bookDetails">
      <div class="book-placeholder">Loading a random book recommendation...</div>
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
  
  .sidebar-toggle {
    display: none;
    width: 100%;
    padding: 0.6rem;
    background-color: #f0f0f0;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-bottom: 1rem;
    cursor: pointer;
    font-weight: bold;
    text-align: center;
  }
  
  @media (max-width: 768px) {
    body, html {
      overflow-x: hidden;
      overflow-y: auto;
    }
    
    div[style*="display: flex"] {
      display: block !important;
      gap: 0 !important;
    }
    
    .books-container {
      flex-direction: column;
    }
    
    /* Mobile layout adjustments */
    [style*="display: flex"] {
      flex-direction: column;
    }
    
    .sidebar-toggle {
      display: block;
    }
    
    .books-sidebar {
      flex: 0 0 auto;
      border-right: none;
      border-bottom: 1px solid #eaeaea;
      padding-right: 0;
      padding-bottom: 1rem;
      margin-bottom: 1rem;
      order: 1;
      position: static;
      height: auto;
      max-height: none;
      overflow: visible;
    }
    
    /* Default hidden state for mobile */
    .mobile-collapsed #bookList,
    .mobile-collapsed #bookSearch {
      display: none;
    }
    
    .books-content {
      order: 0;
      margin-bottom: 1.5rem;
      overflow: visible;
      height: auto;
    }
    
    #bookList {
      max-height: none;
      overflow-y: visible;
      margin-bottom: 1rem;
      position: static;
    }
    
    .book-item {
      padding: 0.6rem 0.8rem;
      margin-bottom: 0.3rem;
      font-size: 0.85rem;
      display: block;
      white-space: normal;
      background-color: #f9f9f9;
      border: 1px solid #eaeaea;
      border-radius: 4px;
      overflow: hidden;
      text-overflow: ellipsis;
      line-height: 1.3;
    }
    
    .book-item.active {
      background-color: #e0e7ff;
      border-color: #c0c9ff;
      position: relative;
    }
    
    .book-item.active::after {
      content: '👈';
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
    }
    
    .book-image {
      flex: 0 0 auto;
      max-width: 65%;
      margin: 0 auto 1.5rem;
    }
    
    .book-detail-flex {
      flex-direction: column;
      align-items: center;
    }
    
    .book-info {
      width: 100%;
    }
    
    h2 {
      font-size: 1.5rem;
      margin-bottom: 1rem;
      text-align: center;
    }
    
    .book-placeholder {
      padding: 2rem 1rem;
    }
    
    #bookSearch {
      font-size: 0.9rem;
      padding: 0.5rem;
      margin-bottom: 0.5rem;
    }
    
    /* Classes controlled by JavaScript */
    .sidebar-collapsed #bookList,
    .sidebar-collapsed #bookSearch {
      display: none;
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
    
    // Add sidebar toggle for mobile
    const sidebar = document.querySelector('.books-sidebar');
    const sidebarToggle = document.createElement('button');
    sidebarToggle.className = 'sidebar-toggle';
    sidebarToggle.textContent = 'Show Book List';
    sidebarToggle.setAttribute('aria-label', 'Toggle book list visibility');
    sidebarToggle.setAttribute('type', 'button');
    
    // Insert the toggle button before the search input
    const searchContainer = document.getElementById('bookSearch').parentNode;
    searchContainer.insertBefore(sidebarToggle, searchContainer.firstChild);
    
    // Initialize sidebar for JavaScript control
    if (window.innerWidth <= 768) {
      sidebar.classList.add('sidebar-collapsed');
      // Remove the CSS-only class now that JS is in control
      sidebar.classList.remove('mobile-collapsed');
      sidebarToggle.textContent = 'Show Book List';
      
      // Ensure body has no overflow issues on mobile
      document.body.style.overflow = 'auto';
      document.documentElement.style.overflow = 'auto';
    } else {
      // On desktop, ensure the mobile-collapsed class is removed 
      sidebar.classList.remove('mobile-collapsed');
    }
    
    // Toggle sidebar visibility on click
    sidebarToggle.addEventListener('click', function() {
      sidebar.classList.toggle('sidebar-collapsed');
      sidebarToggle.textContent = sidebar.classList.contains('sidebar-collapsed') 
        ? 'Show Book List' 
        : 'Hide Book List';
        
      // Scroll to make selected book visible when showing the list
      if (!sidebar.classList.contains('sidebar-collapsed')) {
        const activeBook = document.querySelector('.book-item.active');
        if (activeBook) {
          setTimeout(() => {
            activeBook.scrollIntoView({ behavior: 'smooth', block: 'center' });
          }, 100);
        }
      }
    });
    
    // Function to select book by slug
    function selectBookBySlug(slug) {
      console.log('Selecting book by slug:', slug);
      const bookItem = document.querySelector(`[data-book-slug="${slug}"]`);
      if (bookItem) {
        const bookId = bookItem.getAttribute('data-book-id');
        
        // Update active state
        bookItems.forEach(i => i.classList.remove('active'));
        bookItem.classList.add('active');
        
        // Show selected book details
        bookDetails.forEach(detail => detail.style.display = 'none');
        document.getElementById('book-' + bookId).style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
        
        // Scroll the selected book into view in the sidebar
        bookItem.scrollIntoView({ behavior: 'smooth', block: 'center' });
        
        // Auto-collapse sidebar on mobile after selection
        if (window.innerWidth <= 768) {
          sidebar.classList.add('sidebar-collapsed');
          sidebarToggle.textContent = 'Show Book List';
        }
        
        return true;
      }
      console.log('Book not found for slug:', slug);
      return false;
    }
    
    // Function to generate slug from title
    function generateSlug(title) {
      return title.toLowerCase()
        .replace(/[^\w\s-]/g, '')
        .replace(/\s+/g, '-')
        .replace(/-+/g, '-')
        .trim('-');
    }
    
    // Handle book selection
    bookItems.forEach(function(item) {
      item.addEventListener('click', function() {
        const bookId = this.getAttribute('data-book-id');
        const bookSlug = this.getAttribute('data-book-slug');
        
        // Update active state
        bookItems.forEach(i => i.classList.remove('active'));
        this.classList.add('active');
        
        // Show selected book details
        bookDetails.forEach(detail => detail.style.display = 'none');
        document.getElementById('book-' + bookId).style.display = 'block';
        if (placeholder) placeholder.style.display = 'none';
        
        // Update URL hash
        if (bookSlug) {
          window.history.pushState(null, null, '#' + bookSlug);
        }
        
        // Auto-collapse sidebar on mobile after selection
        if (window.innerWidth <= 768) {
          sidebar.classList.add('sidebar-collapsed');
          sidebarToggle.textContent = 'Show Book List';
        }
      });
    });
    
    // Check if there's a hash in the URL, otherwise show random book
    let bookSelected = false;
    if (window.location.hash) {
      const slug = window.location.hash.substring(1);
      console.log('Hash found in URL:', slug);
      bookSelected = selectBookBySlug(slug);
    }
    
    // Show a random book by default if no hash or hash didn't match
    if (!bookSelected && bookItems.length > 0 && bookDetails.length > 0) {
      console.log('No hash found or book not selected, showing random book');
      // Generate a random index
      const randomIndex = Math.floor(Math.random() * bookItems.length);
      
      // Select the random book
      bookItems[randomIndex].classList.add('active');
      document.getElementById('book-' + randomIndex).style.display = 'block';
      if (placeholder) placeholder.style.display = 'none';
      
      // Scroll the selected book into view in the sidebar
      bookItems[randomIndex].scrollIntoView({ behavior: 'smooth', block: 'center' });
      
      // Update URL hash to reflect the selected book
      const selectedSlug = bookItems[randomIndex].getAttribute('data-book-slug');
      if (selectedSlug) {
        window.history.replaceState(null, null, '#' + selectedSlug);
      }
    }
    
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
    
    // Handle browser back/forward navigation
    window.addEventListener('hashchange', function() {
      const slug = window.location.hash.substring(1);
      if (slug) {
        selectBookBySlug(slug);
      }
    });
    
  }, 500);
});
</script> 