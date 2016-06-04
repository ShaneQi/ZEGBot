# ZEGBot

This library wraps the JSON decoding processing, making it easy to decode incoming JSON String to manipulatable objects.

This library wraps the processing of converting objects to Telegram Bot API request parameters and the processing of performing request, making it easy to respond for incoming update.

**This is a server-side swift library based on [Perfect](https://github.com/PerfectlySoft/Perfect).  
Helping build your own Perfect Telegram Bot!**

## Quick Start

Checkout `ZEGBotExample` project, whose `README.md`  walks through a bot's birthing.

## Installation

- Add the 4 files in `Sources` directory to your Perfect server project.

- Put your bot token as a global String named `token` in your Perfect server project.

## Usage

- Decode incoming Update object presented by JSON string:
  ```swift
  func handleRequest(request: WebRequest, response: WebResponse) {
    ...
    let update = ZEGDecoder.decodeUpdate(request.postBodyString)
    ...
  }
  ```

- Get text content of the incoming message:
  ```swift
  ...
  if let message = update?.message, text = message.text {
    // Do something.
  }
  ...
  ```

- Get other type of content if exists:
  ```swift
  ...
  if let message = update?.message, voice = message.voice {
    // Do something.
  }
  ...
  ```

- Send a text message to a chat:
  ```swift
  ...
  if let message = update?.message {
    ZEGResponse.sendMessage(to: message.chat, text: "bar", parse_mode: nil, disable_web_page_preview: nil, disable_notification: nil)
  }
  ...
  ```

- Send a **silent** message with a **none-preview markdown link** to a chat:
  ```swift
  ...
  if let message = update?.message {
    ZEGResponse.sendMessage(to: message.chat, text: "[Google](https://google.com)", parse_mode: .Markdown, disable_web_page_preview: true, disable_notification: true)
  }
  ...
  ```

- In all the sending methods, send to a **Message Object** means **reply** to this specific message. While Send to a **Chat Object** means send to this chat **without replying** to anyone.
  ```swift
  ...
  if let message = update?.message {
    /* This sends a message replying to another message. */
    ZEGResponse.sendMessage(to: message, text: "foo", parse_mode: nil, disable_web_page_preview: nil, disable_notification: nil)
    /* This replies to nobody. */
    ZEGResponse.sendMessage(to: message.chat, text: "foo", parse_mode: nil, disable_web_page_preview: nil, disable_notification: nil)
  }
  ...
  ```

## Dependency

- [Perfect v1.0.0](https://github.com/PerfectlySoft/Perfect/releases/tag/v1.0.0)

## Known Bug

- Some character, such as some emoji char, is expressed as surrogate pair and can't be decoded by PerfectLib v1.0. (Will be fixed in the next PerfectLib release version: [details](https://github.com/PerfectlySoft/Perfect/pull/173))

## Support Types

- Update
- Message
- Chat
- User
- MessageEntity
- Audio
- Document
- PhotoSize
- Sticker
- Video
- Voice
- Contact
- Location
- Venue

Not all the types are supported, checkout more details on [Telegram Bot API](https://core.telegram.org/bots/api#available-types).

## Support Methods

- sendMessage
- forwardMessage
- sendPhoto
- sendAudio
- sendDocument
- sendSticker
- sendVideo
- sendVoice
- sendLocation
- sendVenue
- sendContact
- sendChatAction

Not all the methods are supported, checkout more details on [Telegram Bot API](https://core.telegram.org/bots/api#available-methods).

## License
This project is licensed under [Apache License v2.0](http://www.apache.org/licenses/LICENSE-2.0).
