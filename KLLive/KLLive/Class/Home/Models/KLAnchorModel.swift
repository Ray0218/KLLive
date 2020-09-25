//
//  KLAnchorModel.swift
//  KLLive
//
//  Created by WKL on 2020/9/17.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

 
 

struct KLAnchorModel : Codable {

 
    let avatar : String?
    let birthday : Int?
    let channel : String?
    let charge : Int?
    let focus : Int?// 关注数
    let gameIcon : String?
    let gameId : Int?
    let gameName : String?
    let hot : Int?
    let index : Int?
    let live : Int?// 是否在直播
    let mic : Int?
    let name : String?
    let penqi : Int?
    let pic51 : String?
    let picWebp : String?
    let pk : Int?
    let push : Int?//直播显示方式
    let roomid : String?
    let roomname : String?
    let shortId : String?
    let tags : [Tag]?
    let uid : String?
    let vid : Int?
    let weeklyStar : Int?
    let yearParty : Int?


    enum CodingKeys: String, CodingKey {
        case avatar = "avatar"
        case birthday = "birthday"
        case channel = "channel"
        case charge = "charge"
        case focus = "focus"
        case gameIcon = "gameIcon"
        case gameId = "gameId"
        case gameName = "gameName"
        case hot = "hot"
        case index = "index"
        case live = "live"
        case mic = "mic"
        case name = "name"
        case penqi = "penqi"
        case pic51 = "pic51"
        case picWebp = "picWebp"
        case pk = "pk"
        case push = "push"
        case roomid = "roomid"
        case roomname = "roomname"
        case shortId = "shortId"
        case tags = "tags"
        case uid = "uid"
        case vid = "vid"
        case weeklyStar = "weeklyStar"
        case yearParty = "yearParty"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        birthday = try values.decodeIfPresent(Int.self, forKey: .birthday)
        channel = try values.decodeIfPresent(String.self, forKey: .channel)
        charge = try values.decodeIfPresent(Int.self, forKey: .charge)
        focus = try values.decodeIfPresent(Int.self, forKey: .focus)
        gameIcon = try values.decodeIfPresent(String.self, forKey: .gameIcon)
        gameId = try values.decodeIfPresent(Int.self, forKey: .gameId)
        gameName = try values.decodeIfPresent(String.self, forKey: .gameName)
        hot = try values.decodeIfPresent(Int.self, forKey: .hot)
        index = try values.decodeIfPresent(Int.self, forKey: .index)
        live = try values.decodeIfPresent(Int.self, forKey: .live)
        mic = try values.decodeIfPresent(Int.self, forKey: .mic)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        penqi = try values.decodeIfPresent(Int.self, forKey: .penqi)
        pic51 = try values.decodeIfPresent(String.self, forKey: .pic51)
        picWebp = try values.decodeIfPresent(String.self, forKey: .picWebp)
        pk = try values.decodeIfPresent(Int.self, forKey: .pk)
        push = try values.decodeIfPresent(Int.self, forKey: .push)
        roomid = try values.decodeIfPresent(String.self, forKey: .roomid)
        roomname = try values.decodeIfPresent(String.self, forKey: .roomname)
        shortId = try values.decodeIfPresent(String.self, forKey: .shortId)
        tags = try values.decodeIfPresent([Tag].self, forKey: .tags)
        uid = try values.decodeIfPresent(String.self, forKey: .uid)
        vid = try values.decodeIfPresent(Int.self, forKey: .vid)
        weeklyStar = try values.decodeIfPresent(Int.self, forKey: .weeklyStar)
        yearParty = try values.decodeIfPresent(Int.self, forKey: .yearParty)
    }


}


struct Tag : Codable {

    let tagId : Int?
    let tagName : String?
    let type : Int?


    enum CodingKeys: String, CodingKey {
        case tagId = "tagId"
        case tagName = "tagName"
        case type = "type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tagId = try values.decodeIfPresent(Int.self, forKey: .tagId)
        tagName = try values.decodeIfPresent(String.self, forKey: .tagName)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }


}
