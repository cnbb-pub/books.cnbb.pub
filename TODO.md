# TODO


## In-Progress

* [ ] Move "data" of menus into dedicated module
* [ ] Add color highlights to books, authors, and genres
  * [x] Each should have it's own "theme color"
  * [x] Menus should have a bar of color above/below
  * [ ] Panoramic header images for each top-level page should be in matching color
* [x] Only show side nav on main, books, genres, and authors pages
  * [ ] Create location path content for use above main content
    * http://getbootstrap.com/components/#breadcrumbs
  * [ ] Show path above main content for all non-main-pages

## Not-Started

* [ ] Make subtitle font smaller
* [ ] Update to be responsive
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
* [x] Fix mouse-over on main nav obscuring logo
* [x] Add real items to side nav
  * [x] Update routes to match
* [x] Add real items to top nav
  * [x] Update routes to match
  * [x] Set menus to expand when a link is active
  * [x] Change blue "active" color to light grey
* [x] Rename some more general modules:
  * [x] cnbbsite-templates.lfe -> cnbb-tmpls.lfe
  * [x] cnbbsite-util.lfe -> cnbb-util.lfe
  * [x] cnbbsite-const.lfe -> cnbb-const.lfe
* [-] Fix background color of top nav and main content area to match footers
  * This didn't get fixed, since it was a perceptual problem -- depending
  upon the monitor/display, greys of different darkeness with the same
  values in r, g, and b, will seem to have blue, green, or red highlights
