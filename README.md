keylime is an iOS library that provides data-driven table view and collection view functionality.

In a nutshell keylime will allow you to display heterogeneous collections of objects in a UITableView or UICollectionView without having to write a lot of boilerplate code.

By default keylime will dynamically create the appropriate cell to represent a specific data type (e.g. a KLPerson object will, by default, be displayed using a KLPersonTableViewCell).

The current release of keylime is being extracted from the legacy keylime library, which was a general purpose utility library for iOS. Special attention is being paid to modernizing the structure of keylime's components and avoiding duplication of functionality provided by projects such as AFNetworking or BlocksKit, which are now easily installed with Cocoapods.