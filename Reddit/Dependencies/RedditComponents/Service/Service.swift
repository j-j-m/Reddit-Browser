//
//  Service.swift
//  Reddit
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//
import Moya

private extension String {
    func paginate(with page: String?) -> String {
        let path = self
        guard let p = page else { return path }
        return path + "?after=\(p)"
    }
}

public enum RedditService {
    case main(page: String?)
    case subreddit(id: String, page: String?)
}

extension RedditService: TargetType {
    
    /// The base service URL
    public var baseURL: URL { return URL(string: "https://www.reddit.com")! }
    
    /// Path appended to baseURL
    public var path: String {
        switch self {
        case .main:
            return "/.json"
        case .subreddit(let id, _):
            return "/r/\(id)/.json"
        }
    }
    
    
    /// Represents an HTTP method
    public var method: Moya.Method {
        switch self {
        case .main, .subreddit:
            return .get
        }
    }
    
    /// Represents an HTTP task
    public var task: Task {
        switch self {
        case .main(let p), .subreddit(_, let p):
            guard let page = p else { return .requestPlain }
            return .requestParameters(parameters: ["after" : page], encoding: URLEncoding.queryString)
        }
    }
    
    /// Stub data for testing
    public var sampleData: Data {
        
        //TODO: - establish json file -> test pipeline
///        switch self {
///        case .main:
///            return "".utf8Encoded
///       case .subreddit(let id):
///            return "".utf8Encoded
///        }
        
        return "".utf8Encoded

    }
    
    // The request headers
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
}
