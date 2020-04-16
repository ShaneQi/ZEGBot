//
//  PayloadBuilder.swift
//  ZEGBot
//
//  Created by Shane Qi on 4/15/20.
//

import Foundation

public enum ResourceLocation: Encodable {

    case telegramFileId(String)
    case url(URL)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .telegramFileId(let fileId):
            try container.encode(fileId)
        case .url(let url):
            try container.encode(url)
        }
    }
}

public extension URL {

    var resourceLocation: ResourceLocation {
        return .url(self)
    }

}

public extension String {

    var resourceLocation: ResourceLocation {
        return .telegramFileId(self)
    }

}

protocol TelegramStoredResource {

    var fileId: String { get }

}

extension TelegramStoredResource {

    public var resourceLocation: ResourceLocation {
        return .telegramFileId(fileId)
    }

}

public protocol ResourceLocationConvertible {

    var resourceLocation: ResourceLocation { get }

}

public protocol StickerConvertible: ResourceLocationConvertible {}

extension URL: StickerConvertible {}

extension String: StickerConvertible {}

extension Sticker: TelegramStoredResource, StickerConvertible {}

extension ZEGBot {

    @discardableResult
    public func sendSticker(
        _ sticker: StickerConvertible,
        to receiver: Sendable,
        disableNotification: Bool? = nil,
        replyMarkup: InlineKeyboardMarkup? = nil) throws -> Message {
        let payload = Payload(
            sticker: sticker,
            receiver: receiver,
            disableNotification: disableNotification,
            replyMarkup: replyMarkup)
        return try performRequest(ofMethod: #function, payload: payload)
    }

}

protocol PhotoConvertible: ResourceLocationConvertible {}

extension URL: PhotoConvertible {}

extension String: PhotoConvertible {}

extension PhotoSize: TelegramStoredResource, PhotoConvertible {}

struct Payload: Encodable {

    var sticker: StickerConvertible? = nil

    var receiver: Sendable? = nil

    var disableNotification: Bool? = nil
    var replyMarkup: InlineKeyboardMarkup? = nil

    private enum CodingKeys: String, CodingKey {
        case sticker
        case disableNotification
        case replyMarkup

        case chatId
        case replyToMessageId
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sticker?.resourceLocation, forKey: .sticker)
        try container.encode(disableNotification, forKey: .disableNotification)
        try container.encode(replyMarkup, forKey: .replyMarkup)

        try container.encode(receiver?.chatId, forKey: .chatId)
        try container.encode((receiver as? Replyable)?.replyToMessageId, forKey: .replyToMessageId)
    }

}
