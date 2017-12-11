//
//  RepoInfo.swift
//  GitHubko
//
//  Created by D&M on 22.09.2017..
//  Copyright © 2017. Dunja Sasic. All rights reserved.
//

import Foundation

struct RepoInfo {
    var name: String
    var author: String
    var thumbnailAuthor: URL
    var watchers: Int
    var forks: Int
    var issues: Int
    var stars: Int
    var score: Double
    var language: String
    var created: String
    var updated: String
    var repoURL: URL

    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
        let author = json["owner"] as? [String: Any],
            let authorName = author["login"] as? String,
            let thumbnail = author["avatar_url"] as? String,
            let thumbnailURL = URL(string: thumbnail),
            let watchers = json["watchers"] as? Int,
            let forks = json["forks"] as? Int,
            let issues = json["open_issues"] as? Int,
            let stars = json["stargazers_count"] as? Int,
            let score = json["score"] as? Double,
            let language = json["language"] as? String,
            let created = json["created_at"] as? String,
            let updated = json["updated_at"] as? String,
            let repoStringURL = json["html_url"] as? String,
            let repoURL = URL(string: repoStringURL) else { return nil }

        self.name = name
        self.author = authorName
        self.thumbnailAuthor = thumbnailURL
        self.watchers = watchers
        self.forks = forks
        self.issues = issues
        self.stars = stars
        self.score = score
        self.language = language
        self.created = created
        self.updated = updated
        self.repoURL = repoURL

    }

}
