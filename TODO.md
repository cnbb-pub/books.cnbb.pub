# TODO


## In-Progress

* [x] Add real items to side nav
  * [x] Update routes to match
* [x] Add real items to top nav
  * [x] Update routes to match
  * [ ] Set menus to expand when a link is active
  * [ ] Change blue "active" color to light grey


## Not-Started

* [ ] Make subtitle font smaller
* [ ] Add color highlights to books, authors, and genres
  * [ ] Each should have it's own "theme color"
  * [ ] Menus should have a bar of color above/below
  * [ ] Panoramic header images for each top-level page should be in matching color
* [ ] Rename some more general modules:
  * [ ] cnbbsite-templates.lfe -> cnbb-tmpls.lfe
  * [ ] cnbbsite-util.lfe -> cnbb-util.lfe
  * [ ] cnbbsite-const.lfe -> cnbb-const.lfe
* [ ] Fix mouse-over on main nav obscuring logo
* [ ] Update to be responsive
* [ ] Only show side nav on main, books, genres, and authors pages
  * [ ] Create location path content for use above main content
    * http://getbootstrap.com/components/#breadcrumbs
  * [ ] Show path above main content for all non-main-pages
* [ ] Create author template page
* [ ] Create book template page
* [ ] Create genre template page
* [ ] Store content in Redis
  * [ ] Write code to pull content out of Redis
  * [ ] Support Markdown source and convert to HTML
  * [ ] Write a content editor front-end for Redis
* [ ] Add authentication
* [ ] Add user page


## Done

* [x] Add logging support
* [x] Center subfooter content
* [x] Fill in subfooter
* [x] Add icomoon support
* [x] Add Twitter link
* [x] Separate top nav from side nav
* [x] Lighten footer background color
* [x] Update routes to point to new pages
* [x] Add sticky bottom
  * [-] Add siloutette imagery (maybe later)
* [x] Fill in footer
  * [x] Convert footer menu to function in nav module
  * [x] Add links to footer menu
