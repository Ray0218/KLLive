//
//  KLGiftModel.swift
//  KLLive
//
//  Created by WKL on 2020/9/22.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
 

struct KLGiftPackge : Codable {

    let list : [KLGiftModel]?
    let p : Int?
    var  t : Int = 0
    let tp : Int?


    enum CodingKeys: String, CodingKey {
        case list = "list"
        case p = "p"
        case t = "t"
        case tp = "tp"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([KLGiftModel].self, forKey: .list)
        p = try values.decodeIfPresent(Int.self, forKey: .p)
        t = try (values.decodeIfPresent(Int.self, forKey: .t) ?? 0)
        tp = try values.decodeIfPresent(Int.self, forKey: .tp)
    }


}


struct KLGiftModel : Codable {

    let auth : Int?
    let authInfo : String?
    let bSdkUrl : String?
    let bUrl : String?
    let coin : Int?
    let detail : String?
//    let ext : Ext?
    let gUrl : String?
    let id : Int?
    let img : String?
    let img2 : String?
    let isR : Int?
    let lUrl : String?
    let mSdkUrl : String?
    let mUrl : String?
    let maxNum : Int?
    let oCoin : Int?
    let pCid : Int?
    let sType : SType?
    let subject : String?
    let svgaUrl : String?
    let time : Int?
    let type : Int?
    let w2Url : String?
    let wUrl : String?
    let zUrl : String?
    let zUrl2 : String?


    enum CodingKeys: String, CodingKey {
        case auth = "auth"
        case authInfo = "authInfo"
        case bSdkUrl = "bSdkUrl"
        case bUrl = "bUrl"
        case coin = "coin"
        case detail = "detail"
//        case ext
        case gUrl = "gUrl"
        case id = "id"
        case img = "img"
        case img2 = "img2"
        case isR = "isR"
        case lUrl = "lUrl"
        case mSdkUrl = "mSdkUrl"
        case mUrl = "mUrl"
        case maxNum = "maxNum"
        case oCoin = "oCoin"
        case pCid = "pCid"
        case sType
        case subject = "subject"
        case svgaUrl = "svgaUrl"
        case time = "time"
        case type = "type"
        case w2Url = "w2Url"
        case wUrl = "wUrl"
        case zUrl = "zUrl"
        case zUrl2 = "zUrl2"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        auth = try values.decodeIfPresent(Int.self, forKey: .auth)
        authInfo = try values.decodeIfPresent(String.self, forKey: .authInfo)
        bSdkUrl = try values.decodeIfPresent(String.self, forKey: .bSdkUrl)
        bUrl = try values.decodeIfPresent(String.self, forKey: .bUrl)
        coin = try values.decodeIfPresent(Int.self, forKey: .coin)
        detail = try values.decodeIfPresent(String.self, forKey: .detail)
//        ext = try Ext(from: decoder)
        gUrl = try values.decodeIfPresent(String.self, forKey: .gUrl)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        img2 = try values.decodeIfPresent(String.self, forKey: .img2)
        isR = try values.decodeIfPresent(Int.self, forKey: .isR)
        lUrl = try values.decodeIfPresent(String.self, forKey: .lUrl)
        mSdkUrl = try values.decodeIfPresent(String.self, forKey: .mSdkUrl)
        mUrl = try values.decodeIfPresent(String.self, forKey: .mUrl)
        maxNum = try values.decodeIfPresent(Int.self, forKey: .maxNum)
        oCoin = try values.decodeIfPresent(Int.self, forKey: .oCoin)
        pCid = try values.decodeIfPresent(Int.self, forKey: .pCid)
        sType = try SType(from: decoder)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        svgaUrl = try values.decodeIfPresent(String.self, forKey: .svgaUrl)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        w2Url = try values.decodeIfPresent(String.self, forKey: .w2Url)
        wUrl = try values.decodeIfPresent(String.self, forKey: .wUrl)
        zUrl = try values.decodeIfPresent(String.self, forKey: .zUrl)
        zUrl2 = try values.decodeIfPresent(String.self, forKey: .zUrl2)
    }


}


struct SType : Codable {

    let hit : String?
    let luxury : String?
    let combine : String?


    enum CodingKeys: String, CodingKey {
        case hit = "hit"
        case luxury = "luxury"
        case combine = "combine"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hit = try values.decodeIfPresent(String.self, forKey: .hit)
        luxury = try values.decodeIfPresent(String.self, forKey: .luxury)
        combine = try values.decodeIfPresent(String.self, forKey: .combine)
    }


}


//struct Ext : Codable {
//
//
//
//    enum CodingKeys: String, CodingKey {
//    }
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//    }
//
//
//}
