//
//  DataSource.swift
//  RedditComponents
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import Moya
import Nuke

public protocol UITableViewCellGenerator {
    
    associatedtype CellType
    
    static var cellIdentifier: String { get }
    func genrateCell(_ tableview: UITableView) -> UITableViewCell
}

public protocol Preloadable {
    func preload(in target: Target)
}

public class DataSource<S: TargetType, T: UITableViewCellGenerator>: NSObject, UITableViewDataSource {
    
    /// A populator is a function that defines an interaction between Provider and DataSource
    /// to process and populate a datasource given responses from a service provider.
    public typealias Populator = (MoyaProvider<S>, DataSource<S,T>) -> Void
    
    // Service provider
    let provider = MoyaProvider<S>()
    
    public var nextResourceIdentifier: String?
    
    public var entries: [T] = []
    
    
    /// Population method used internally to populate entities
    private var populate: Populator
    
    
    /// Fill the datasource with entities of type T.
    public func fill() {
        self.populate(provider, self)
    }
    
    // Drain all entries from the datasource
    public func drain() {
        entries = []
        nextResourceIdentifier = nil
        Nuke.Cache.shared.removeAll()
    }
    
    
    /// Regenerate the datasource.
    public func regenerate() {
        self.drain()
        self.fill()
    }

    /// Append entities of type T to the datasource.
    ///
    /// - Parameter entities: array of entities of type T
    public func append(_ entities: [T]) {
        entries.append(contentsOf: entities)
    }
    
    /// Initialize a datasource with a population method.
    ///
    /// - Parameter p: population method implementation.
    public init(_ p: @escaping Populator) {
        self.populate = p
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = entries[row].genrateCell(tableView)

        return cell
    }
    
}

/// sadly not supported. 

//extension DataSource: UITableViewDataSource {
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return entries.count
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
