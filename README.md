UISearchBar-bug
===============

A small project that shows a UISearchBar resizing bug (With UISearchDisplayController)

Reson for your bugs is

You initialize a search display controller with a search bar and a view controller responsible for managing the data to be searched. When the user starts a search, the search display controller superimposes the search interface over the original view controller’s view and shows the search results in its table view.
