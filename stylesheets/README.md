# Stylesheet Guide

This directory contains the CSS styling for the Sonoxhibit Jekyll site. This guide explains how to use the available styles in your markdown content.

## Overview

The `screen.css` file provides a complete style system for:
- Index navigation layout
- Exhibit display
- Blog posts and entries
- Forms and buttons
- Responsive images
- Typography and headings

## Layout Structure

The site uses a two-column layout defined by two main containers:

### `#index` (Left Sidebar)
- **Width**: 215px fixed width
- **Position**: Fixed left sidebar
- **Purpose**: Navigation and section listings
- Contains sections, subsections, and exhibit links

### `#exhibit` (Main Content)
- **Margin-left**: 215px (accommodates the fixed index)
- **Purpose**: Primary content display area
- All exhibits and pages display here

## Using Styles in Markdown

### Typography

#### Headings
All headings (h1-h4) are styled with:
- **Font size**: 13px
- **Font weight**: Bold
- **Margin**: 1em top and bottom
- **Max width**: 550px (in index), auto (in exhibits)

```markdown
# Main Heading
## Subheading
### Section Heading
#### Detail Heading
```

#### Paragraphs
- **Exhibit paragraphs** (`#exhibit p`): Width 60% of exhibit area, margin-bottom 1em
- **Index paragraphs** (`#index p`): Auto width, margin-bottom 1em

#### Text Formatting
- **Bold**: `<strong>` or `<b>` tags
- **Italic**: `<em>` or `<i>` tags
- **Code**: Use `<code>` tags (monospace font)
- **Blockquotes**: Use `>` syntax (9px left padding)

```markdown
This is **bold text** and this is *italic text*.

> This is a blockquote with left padding
```

### Lists

#### Unordered Lists
- Style: Disc bullets
- Width: 60% of exhibit area
- Margin-bottom: 1.5em
- Item spacing: 0.5em between items

```markdown
- Item one
- Item two
- Item three
```

#### Ordered Lists
- Style: Decimal numbering
- Width: 60% of exhibit area
- Margin-bottom: 1.5em
- Item spacing: 0.5em between items

```markdown
1. First step
2. Second step
3. Third step
```

### Images

#### Standard Images
Images in exhibits automatically receive:
- **Border**: 1px solid #ddd
- **Margin**: 1em top and bottom
- **Max-width**: 100% (responsive)
- **Display**: Block

```markdown
![Alt text](path/to/image.jpg)
```

#### Images Without Borders
Add the `sinBorde` class to remove the border:

```html
<img src="path/to/image.jpg" alt="Alt text" class="sinBorde">
```

#### Responsive Pictures
Use the Jekyll picture tag for responsive images:

```liquid
{% picture path/to/image %}
```

This automatically gets:
- **Max-width**: 100%
- **Height**: Auto
- **Display**: Block

#### Constrained Images
Wrap images in a div with max-width style:

```html
<div style="max-width: 300px;">
  ![Alt text](path/to/image.jpg)
</div>
```

The wrapper will:
- Constrain the image to the specified width
- Maintain responsive behavior
- Remove default exhibit margins

## Links

### Index Links
- **Default**: Underline removed, black color
- **Hover**: Underline appears
- **Visited**: Gray color (#666)
- **Active**: Green color (#00cc00)

### Exhibit Links
- **Default**: Underlined, black color
- **Hover**: Underline style applied
- **Visited**: Gray color
- **Active**: Green color (#00cc00)

### Link Styling
```html
<a href="page.html">Link text</a>
```

## Forms

### Form Rows
Basic form structure:

```html
<div class="form-row">
  <div class="form-label">
    <label for="field">Field Label:</label>
  </div>
  <div class="form-input">
    <input type="text" id="field" name="field">
  </div>
</div>
```

### Form Inputs
Styled inputs and textareas:
- **Font**: Helvetica Neue, 1em, line-height 1.4
- **Margin**: 0.5em bottom
- **Padding**: 0.3em

Supported input types:
- `<input type="text">`
- `<input type="password">`
- `<textarea></textarea>`

### Form Buttons
Submit buttons:
- **Background**: Dark gray (#333)
- **Hover**: Green (#0c0)
- **Padding**: 9px 12px
- **Border-radius**: 3px
- **Color**: White

```html
<div class="form-submit">
  <input type="submit" value="Send">
</div>
```

### Form Feedback
Display form alerts:

```html
<div class="form-alert">
  <div class="failed">Error message here</div>
</div>
```

## Buttons

### Button Styling
Use the `.buttons` class for styled button links:

```html
<div class="buttons">
  <button><a href="link.html">Button Text</a></button>
  <button><a href="link2.html">Another Button</a></button>
</div>
```

Button styles:
- **Background**: Dark gray (#333) by default
- **Hover**: Green (#0c0)
- **Active**: Green (#0c0)
- **Padding**: 9px 12px
- **Border-radius**: 3px
- **Font size**: 1em (12px on active/hover)

## Blog Styling

### Blog Container
Main blog wrapper:
- **Width**: 800px
- Contains entries and sidebar

### Blog Entries
Individual blog posts:
- **Width**: 525px
- **Float**: Left
- Paragraphs automatically expand to full width

### Entry Elements
```html
<div class="entry">
  <h2>Entry Title</h2>
  <p>Entry content...</p>
  
  <div class="asset">
    <!-- Image or media -->
  </div>
  
  <div class="captioning">
    <div class="title">Caption Title</div>
    <div class="caption">Caption text</div>
  </div>
  
  <div class="entry_footer">
    Posted by Author | Date
  </div>
</div>

<div class="separator"></div>
```

### Blog Sidebar
Right-side sidebar in blog view:
- **Float**: Right
- **Width**: 200px
- Contains previous/new entries navigation

### Navigation
Previous and newer entry navigation:

```html
<div id="prev_new_entries">
  <div id="older">← Older Entries</div>
  <div id="newer">Newer Entries →</div>
</div>
```

## Special Classes

### `.highlight`
Highlight important text or code blocks:
- **Background**: Lime yellow (#ccff00)
- **Color**: Black

```markdown
This text is `highlighted` in lime yellow.
```

### `.container`
Main content container with padding:
- **Padding**: 27px 9px 25px 27px

### `.clL` / `.once`
Clear floats to the left:

```html
<div class="clL">Clear float content</div>
```

### `.sinBorde`
Remove default image borders (Spanish for "without border"):

```html
<img src="image.jpg" class="sinBorde" alt="No border image">
```

## Body Classes for Custom Styling

Use these body classes to apply custom styles to specific sections or exhibits:

### Section-based Styling
```html
<!-- Styles applied to entire section -->
<body class="section-1">
<body class="section-2">
```

### Exhibit-based Styling
```html
<!-- Styles applied to specific exhibit -->
<body class="exhibit-12">
```

### Format-based Styling
```html
<!-- Styles applied to specific exhibit format -->
<body class="visual_index">
```

You can add custom CSS rules targeting these classes:

```css
body.section-1 { /* custom styles */ }
body.exhibit-12 { /* custom styles */ }
```

## Customization Tips

### Changing Link Colors
Modify these rules in `screen.css`:

```css
a:link { color: #000; }           /* Default link color */
a:visited { color: #666; }        /* Visited link color */
a:hover { text-decoration: underline; }  /* Hover effect */
a:active { color: #00cc00; }      /* Active link color */
```

### Adjusting Content Width
Modify the width values:

```css
#index { width: 215px; }                /* Index sidebar width */
#exhibit { margin: 0 0 0 215px; }       /* Content area offset */
#exhibit p { width: 60%; }              /* Paragraph width (60% of available area) */
h1, h2, h3 { width: 60%; }              /* Heading width (60% of available area) */
```

### Changing Colors
Main color scheme values:
- **Background**: `#fff` (white)
- **Text**: `#000` (black)
- **Accent**: `#0c0` (lime green)
- **Subtle**: `#666` (gray)
- **Border**: `#ddd` (light gray)

### Font Changes
Default typography:

```css
body {
  font-family: 'Helvetica Neue', Arial, Helvetica, Verdana, sans-serif;
  font-size: 13px;
  line-height: 1.3em;
}
```

## Common HTML Patterns

### Full-width Image Container
```html
<div style="max-width: 600px;">
  ![Wide image](image.jpg)
</div>
```

### Image with Caption
```html
<figure>
  ![Image](photo.jpg)
  <figcaption>This is the caption text</figcaption>
</figure>
```

### Multi-column Content
```html
<div id="columned">
  <p>Content automatically expands to full width</p>
</div>
```

### Navigation List
```html
<ul class="section">
  <li class="exhibit_title"><a href="#">Exhibit Name</a></li>
  <li class="exhibit_link"><a href="#">Exhibit Link</a></li>
</ul>
```

## Notes

- All widths and margins are in `em` or `px` units for precise control
- The design uses a fixed sidebar layout - do not modify `#index` positioning without understanding the consequences
- Image borders and margins help with visual hierarchy - remove thoughtfully
- The green accent color (#0c0) is used throughout for interactive elements
- Blog styling assumes a maximum 800px width for optimal readability

## Support

For additional customization or issues, refer to:
- The main Sonoxhibit documentation
- Jekyll documentation for theme modifications
- CSS comments in `screen.css` for specific property explanations
