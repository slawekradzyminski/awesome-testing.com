const fs = require('fs');
const path = require('path');

// Read books.json
const booksJson = require('../_data/books.json');

// Convert to YAML format
const yamlContent = booksJson.map(book => {
    return `- title: "${book.title.replace(/"/g, '\\"')}"
  link: "${book.link}"
  path: "/${book.path}"
  description: "${book.description.replace(/"/g, '\\"')}"`
}).join('\n');

// Write to _data/books.yml
fs.writeFileSync(path.join(__dirname, '../_data/books.yml'), yamlContent);
console.log('Successfully converted books.json to books.yml'); 