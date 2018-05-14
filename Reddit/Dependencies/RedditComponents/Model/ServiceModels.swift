//
//  ServiceModels.swift
//  RedditComponents
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//


import Foundation
import Nuke

public struct RedditResponse: Codable {
    public let kind: String
    public let data: Listing
}

public struct Listing: Codable {
    /// elements of the list
    public let children: [ThingContainer]
    public let before: String?
    public let after: String?
    
}

public struct ThingContainer: Codable {
    public let kind: String
    public let data: Thing
}


/// The actual reddit post
public struct Thing: Codable {
    public let name: String
    public let title: String
    public let subreddit: String
    public let thumbnail: String
    public let permalink: String 
    
}

extension Thing: UITableViewCellGenerator {
    
    public typealias CellType = PostCell
    
    public static let cellIdentifier: String = "ThingCell"
    
    //TODO: - probably could improve this
    
    /// Generate tableview cell from entity.
    ///
    /// - Parameter tableview: tableview for cell
    /// - Returns: tableview cell
    public func genrateCell(_ tableview: UITableView) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: Thing.cellIdentifier) as! CellType

        cell.titleLabel.text = title
        cell.subredditLabel.text = "r/" + subreddit
        
        // load image into cells image view if thumb url exists
        if let url = URL(string: thumbnail) {
            Nuke.Manager.shared.loadImage(with: url,
                                          into: cell.imgView)
        }

        return cell
    }
    
}
