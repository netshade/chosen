# Fork Details

This fork adds:

* Collapsible groups
* Decorator support ( programatically alter content as it's inserted into the result list )
* Method call support ( `$("#select-box").chosen('method-name', arg1, arg2)` )
* Arbitrary choice insertion
* Event fired when no item matches the user's input when they hit enter
* Big performance improvements for large data sets by using direct DOM insertion via Document Fragments
* Sliding window style dom tree building of result sets such that you never load all n-thousand dom nodes at click time, but rather load them at view time based on scroll position

Note that this fork has moved fairly far from its original roots, so use at your own discretion. These improvements are mostly to support my own needs. ( Also these changes are just for the jQuery version, no intent to support any Prototype port )


# Chosen

Chosen is a library for making long, unwieldy select boxes more user friendly.

- jQuery support: 1.4+
- Prototype support: 1.7+

For **documentation**, usage, and examples, see:  
http://harvesthq.github.io/chosen/

For **downloads**, see:  
https://github.com/harvesthq/chosen/releases/

### Contributing to this project

We welcome all to participate in making Chosen the best software it can be. The repository is maintained by only a few people, but has accepted contributions from over 50 authors after reviewing hundreds of pull requests related to thousands of issues. You can help reduce the maintainers' workload (and increase your chance of having an accepted contribution to Chosen) by following the
[guidelines for contributing](contributing.md).

* [Bug reports](contributing.md#bugs)
* [Feature requests](contributing.md#features)
* [Pull requests](contributing.md#pull-requests)

### Chosen Credits

- Concept and development by [Patrick Filler](http://patrickfiller.com) for [Harvest](http://getharvest.com/).
- Design and CSS by [Matthew Lettini](http://matthewlettini.com/)
- Repository maintained by [@pfiller](http://github.com/pfiller), [@kenearley](http://github.com/kenearley), [@stof](http://github.com/stof) and [@koenpunt](http://github.com/koenpunt).
- Chosen includes [contributions by many fine folks](https://github.com/harvesthq/chosen/contributors).
