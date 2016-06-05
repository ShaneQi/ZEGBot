//
//  ZZEGBotDecodeMessageTests.swift
//  ZEGBotTests
//
//  Created by Shane Qi on 5/16/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

import XCTest
@testable import ZEGBot

class ZEGBotDecodeMessageTests: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDecodeBasicType() {
	
		let updateString = "{\"update_id\":719535978, \"message\":{\"message_id\":36891,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464538624,\"forward_from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"forward_date\":1464538615,\"text\":\"test\\ud83d\\ude33\"}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.message_id == 36891)
		XCTAssert(update?.message?.date == 1464538624)
		XCTAssert(update?.message?.forward_date == 1464538615)
		XCTAssert(update?.message?.text == "test😳")
		
		let updateStringEdit = "{\"update_id\":719535989, \"edited_message\":{\"message_id\":36896,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464539230,\"edit_date\":1464540319,\"text\":\"edit test\"}}"
		
		let updateEdit = ZEGDecoder.decodeUpdate(updateStringEdit)
		
		XCTAssert(updateEdit?.edited_message != nil)
		XCTAssert(updateEdit?.edited_message?.message_id == 36896)
		XCTAssert(updateEdit?.edited_message?.edit_date == 1464540319)
		
		let updateStringNewChatTitle = "{\"update_id\":719535990, \"message\":{\"message_id\":36903,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroupNewTitle\",\"type\":\"group\"},\"date\":1464541152,\"new_chat_title\":\"TestGroupNewTitle\"}}"
		
		let updateNewChatTitle = ZEGDecoder.decodeUpdate(updateStringNewChatTitle)
		
		XCTAssert(updateNewChatTitle?.message?.new_chat_title == "TestGroupNewTitle")
		
		let updateStringDeleteChatPhoto = "{\"update_id\":719535992, \"message\":{\"message_id\":36905,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroupNewTitle\",\"type\":\"group\"},\"date\":1464541512,\"delete_chat_photo\":true}}"
		
		let updateDeleteChatPhoto = ZEGDecoder.decodeUpdate(updateStringDeleteChatPhoto)
	
		XCTAssert(updateDeleteChatPhoto?.message?.delete_chat_photo == true)
		
		let updateStringGroupCreated = "{\"update_id\":719535983, \"message\":{\"message_id\":36899,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroup\",\"type\":\"group\"},\"date\":1464539374,\"group_chat_created\":true}}"
		
		let updateGroupCreated = ZEGDecoder.decodeUpdate(updateStringGroupCreated)
		
		XCTAssert(updateGroupCreated?.message?.group_chat_created == true)
		
		let updateStringMigrateTo = "{\"update_id\":719535993, \"message\":{\"message_id\":36906,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroupNewTitle\",\"type\":\"group\"},\"date\":1464541794,\"migrate_to_chat_id\":-1001054388862}}"
		
		let updateMigrateTo = ZEGDecoder.decodeUpdate(updateStringMigrateTo)
		
		XCTAssert(updateMigrateTo?.message?.migrate_to_chat_id == -1001054388862)
	
		let updateStringMigrateFrom = "{\"update_id\":719535994, \"message\":{\"message_id\":1,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-1001054388862,\"title\":\"TestGroupNewTitle\",\"type\":\"supergroup\"},\"date\":1464541794,\"migrate_from_chat_id\":-118671435}}"
		
		let updateMigrateFrom = ZEGDecoder.decodeUpdate(updateStringMigrateFrom)
		
		XCTAssert(updateMigrateFrom?.message?.migrate_from_chat_id == -118671435)

	}
	
	func testDecodeChat() {
		let updateStringPrivate = "{\"update_id\":719535604, \"message\":{\"message_id\":36508,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464408889,\"text\":\"test\"}}"
		
		let updateStringGroup = "{\"update_id\":719535605, \"message\":{\"message_id\":36509,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-107883184,\"title\":\"\\u6298\\u8033\\u6839\\u7684\\u670b\\u53cb\\u4eec\\u548c\\u4ed6\",\"type\":\"group\"},\"date\":1464408898,\"text\":\"test\"}}"
		
		let updateStringForward = "{\"update_id\":719535979, \"message\":{\"message_id\":36893,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464539037,\"forward_from_chat\":{\"id\":-1001063754163,\"title\":\"TestChannel\",\"type\":\"channel\"},\"forward_date\":1464539028,\"text\":\"test\"}}"
		
		let updatePerson = ZEGDecoder.decodeUpdate(updateStringPrivate)
		XCTAssert(updatePerson?.message?.chat.id == 80548625)
		XCTAssert(updatePerson?.message?.chat.type == "private")
		XCTAssert(updatePerson?.message?.chat.username == "ShaneQi")
		XCTAssert(updatePerson?.message?.chat.first_name == "Shane")
		XCTAssert(updatePerson?.message?.chat.last_name == "Qi")
		
		let updateGroup = ZEGDecoder.decodeUpdate(updateStringGroup)
		XCTAssert(updateGroup?.message?.chat.title == "折耳根的朋友们和他")
	
		let updateForward = ZEGDecoder.decodeUpdate(updateStringForward)
		XCTAssert(updateForward?.message?.forward_from_chat!.id == -1001063754163)
		XCTAssert(updateForward?.message?.forward_from_chat!.title == "TestChannel")
		XCTAssert(updateForward?.message?.forward_from_chat!.type == "channel")
	}
	
	func testDecodeUser() {
		
		let updateStringFrom = "{\"update_id\":719535604, \"message\":{\"message_id\":36508,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464408889,\"text\":\"test\"}}"
		
		let updateStringForwardFrom = "{\"update_id\":719535982, \"message\":{\"message_id\":36897,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464539242,\"forward_from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"forward_date\":1464539230,\"text\":\"test\"}}"
		
		let updateStringNewMember = "{\"update_id\":719535984, \"message\":{\"message_id\":36900,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroup\",\"type\":\"group\"},\"date\":1464539443,\"new_chat_participant\":{\"id\":70475313,\"first_name\":\"Jake\",\"last_name\":\"Dai\",\"username\":\"Disaur\"},\"new_chat_member\":{\"id\":70475313,\"first_name\":\"Jake\",\"last_name\":\"Dai\",\"username\":\"Disaur\"}}}"
		
		let updateStringLeftMember = "{\"update_id\":719535985, \"message\":{\"message_id\":36901,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroup\",\"type\":\"group\"},\"date\":1464539458,\"left_chat_participant\":{\"id\":70475313,\"first_name\":\"Jake\",\"last_name\":\"Dai\",\"username\":\"Disaur\"},\"left_chat_member\":{\"id\":70475313,\"first_name\":\"Jake\",\"last_name\":\"Dai\",\"username\":\"Disaur\"}}}"
		
		let updateFrom = ZEGDecoder.decodeUpdate(updateStringFrom)
		XCTAssert(updateFrom?.message?.from?.id == 80548625)
		XCTAssert(updateFrom?.message?.from?.first_name == "Shane")
		XCTAssert(updateFrom?.message?.from?.last_name == "Qi")
		XCTAssert(updateFrom?.message?.from?.username == "ShaneQi")
		
		let updateForwardFrom = ZEGDecoder.decodeUpdate(updateStringForwardFrom)
		XCTAssert(updateForwardFrom?.message?.forward_from?.id == 80548625)
		XCTAssert(updateForwardFrom?.message?.forward_from?.first_name == "Shane")
		XCTAssert(updateForwardFrom?.message?.forward_from?.last_name == "Qi")
		XCTAssert(updateForwardFrom?.message?.forward_from?.username == "ShaneQi")
		
		let updateNewMember = ZEGDecoder.decodeUpdate(updateStringNewMember)
		XCTAssert(updateNewMember?.message?.new_chat_member?.id == 70475313)
		XCTAssert(updateNewMember?.message?.new_chat_member?.first_name == "Jake")
		XCTAssert(updateNewMember?.message?.new_chat_member?.last_name == "Dai")
		XCTAssert(updateNewMember?.message?.new_chat_member?.username == "Disaur")

		let updateLeftMember = ZEGDecoder.decodeUpdate(updateStringLeftMember)
		XCTAssert(updateLeftMember?.message?.left_chat_member?.id == 70475313)
		XCTAssert(updateLeftMember?.message?.left_chat_member?.first_name == "Jake")
		XCTAssert(updateLeftMember?.message?.left_chat_member?.last_name == "Dai")
		XCTAssert(updateLeftMember?.message?.left_chat_member?.username == "Disaur")
		
	}
	
	func testRecursivelyDecodeMessage() {
	
		let updateStringReply = "{\"update_id\":719535986, \"message\":{\"message_id\":36902,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464539896,\"reply_to_message\":{\"message_id\":36898,\"from\":{\"id\":199112411,\"first_name\":\"zeg_bot\",\"username\":\"zeg_bot\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464539243,\"text\":\"test\"},\"text\":\"reply test\"}}"
		
		let updateStringPinned = "{\"update_id\":719535988, \"message\":{\"message_id\":18199,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-1001030735907,\"title\":\"\\u6298\\u8033\\u6839\\u548c\\u4ed6\\u7684\\u670b\\u53cb\\u4eec\",\"type\":\"supergroup\"},\"date\":1464540123,\"pinned_message\":{\"message_id\":18198,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-1001030735907,\"title\":\"\\u6298\\u8033\\u6839\\u548c\\u4ed6\\u7684\\u670b\\u53cb\\u4eec\",\"type\":\"supergroup\"},\"date\":1464540116,\"text\":\"test\"}}}"
		
		let updateReply = ZEGDecoder.decodeUpdate(updateStringReply)
		
		XCTAssert(updateReply?.message?.reply_to_message != nil)
		XCTAssert(updateReply?.message?.reply_to_message?.message_id == 36898)
		
		let updatePinned = ZEGDecoder.decodeUpdate(updateStringPinned)
		
		XCTAssert(updatePinned?.message?.pinned_message != nil)
		XCTAssert(updatePinned?.message?.pinned_message?.message_id == 18198)
		
	}
	
	func testDecodeMessageEntityArray() {
	
		let updateString = "{\"update_id\":719535831, \"message\":{\"message_id\":36743,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464497226,\"text\":\"\\/test https:\\/\\/google.com @ShaneQi\",\"entities\":[{\"type\":\"bot_command\",\"offset\":0,\"length\":5},{\"type\":\"url\",\"offset\":6,\"length\":18},{\"type\":\"mention\",\"offset\":25,\"length\":8},{\"type\":\"text_link\",\"offset\":37,\"length\":5,\"url\":\"https:\\/\\/zhanga.ru\\/\"}]}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.entities != nil)
		XCTAssert(update?.message?.entities!.count == 4)
		XCTAssert(update?.message?.entities![0].type == "bot_command")
		XCTAssert(update?.message?.entities![1].offset == 6)
		XCTAssert(update?.message?.entities![2].length == 8)
		XCTAssert(update?.message?.entities![3].url == "https://zhanga.ru/")
		
	}
	
	func testDecodeAudio() {
	
		let updateString = "{\"update_id\":719535841, \"message\":{\"message_id\":36753,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464499762,\"forward_from\":{\"id\":79113659,\"first_name\":\"\\ud83d\\udc89\\ud83d\\udc8a\",\"last_name\":\"\\u6bd2\\u85ac\\u264f\\ufe0f\",\"username\":\"duyaoo\"},\"forward_date\":1446132050,\"audio\":{\"duration\":351,\"mime_type\":\"audio\\/mp4\",\"title\":\"\\u30aa\\u30ec\\u30f3\\u30b8\",\"performer\":\"7!!\",\"file_id\":\"BQADBQADzwADuy23BKu8f1YGCTP2Ag\",\"file_size\":11392132}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.audio?.file_id == "BQADBQADzwADuy23BKu8f1YGCTP2Ag")
		XCTAssert(update?.message?.audio?.duration == 351)
		XCTAssert(update?.message?.audio?.performer == "7!!")
		XCTAssert(update?.message?.audio?.title == "オレンジ")
		XCTAssert(update?.message?.audio?.mime_type == "audio/mp4")
		XCTAssert(update?.message?.audio?.file_size == 11392132)
	
	}
	
	func testDecodeDocument() {
	
		let updateString = "{\"update_id\":719535843, \"message\":{\"message_id\":36755,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464500964,\"document\":{\"file_name\":\"0007.jpg\",\"mime_type\":\"image\\/jpeg\",\"thumb\":{\"file_id\":\"AAQFABOY0L8yAARzaomx_igDWjMDAAIC\",\"file_size\":3898,\"width\":90,\"height\":90},\"file_id\":\"BQADBQADNAEAAhETzQRgwUbBAeEG7wI\",\"file_size\":482312}, \"caption\":\"test\"}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message!.document!.file_id == "BQADBQADNAEAAhETzQRgwUbBAeEG7wI")
		XCTAssert(update?.message!.document!.file_name == "0007.jpg")
		XCTAssert(update?.message!.document!.mime_type == "image/jpeg")
		XCTAssert(update?.message!.document!.file_size == 482312)
		XCTAssert(update?.message?.caption == "test")
		
		let thumb = update!.message!.document!.thumb
		
		XCTAssert(thumb != nil)
		XCTAssert(thumb!.file_id == "AAQFABOY0L8yAARzaomx_igDWjMDAAIC")
		XCTAssert(thumb!.width == 90)
		XCTAssert(thumb!.height == 90)
		XCTAssert(thumb!.file_size == 3898)
	
	}
	
	func testDecodePhotoSizeArray() {
		
		let updateString = "{\"update_id\":719535947, \"message\":{\"message_id\":36860,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464535072,\"forward_from\":{\"id\":79630528,\"first_name\":\"Tao\",\"last_name\":\"Liu\",\"username\":\"TaoLiu\"},\"forward_date\":1464313883,\"photo\":[{\"file_id\":\"AgADAwADtacxG8AQvwQNpE8e0bCRkKz0hjEABLgIRfx4oqTm5ZEAAgI\",\"file_size\":2324,\"file_path\":\"photo\\/file_3730.jpg\",\"width\":90,\"height\":90},{\"file_id\":\"AgADAwADtacxG8AQvwQNpE8e0bCRkKz0hjEABG7zoyhICRg75pEAAgI\",\"file_size\":33232,\"width\":320,\"height\":320},{\"file_id\":\"AgADAwADtacxG8AQvwQNpE8e0bCRkKz0hjEABJwzPhKB6-7Y5JEAAgI\",\"file_size\":74558,\"width\":600,\"height\":600}], \"caption\":\"test\"}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.photo?.count == 3)
		XCTAssert(update?.message?.photo![0].file_id == "AgADAwADtacxG8AQvwQNpE8e0bCRkKz0hjEABLgIRfx4oqTm5ZEAAgI")
		XCTAssert(update?.message?.photo![1].width == 320)
		XCTAssert(update?.message?.photo![2].height == 600)
		XCTAssert(update?.message?.photo![2].file_size == 74558)
		XCTAssert(update?.message?.caption == "test")
		
		let updateStringNewChatPhoto = "{\"update_id\":719535991, \"message\":{\"message_id\":36904,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":-118671435,\"title\":\"TestGroupNewTitle\",\"type\":\"group\"},\"date\":1464541294,\"new_chat_photo\":[{\"file_id\":\"AgADBQADg6wxGxETzQRUve2yEV8EPCPYvTIABOcYQVoTBHauqIgBAAEC\",\"file_size\":9535,\"width\":160,\"height\":160},{\"file_id\":\"AgADBQADg6wxGxETzQRUve2yEV8EPCPYvTIABI5mf3AboUT4qYgBAAEC\",\"file_size\":27177,\"width\":320,\"height\":320},{\"file_id\":\"AgADBQADg6wxGxETzQRUve2yEV8EPCPYvTIABBG9XPc-KiZtqogBAAEC\",\"file_size\":86726,\"width\":640,\"height\":640},{\"file_id\":\"AgADBQADg6wxGxETzQRUve2yEV8EPCPYvTIABPtpifSnHwbxq4gBAAEC\",\"file_size\":218228,\"width\":1280,\"height\":1280}]}}"
		
		let updateNewChatPhoto = ZEGDecoder.decodeUpdate(updateStringNewChatPhoto)
		
		XCTAssert(updateNewChatPhoto?.message?.new_chat_photo?.count == 4)
		XCTAssert(updateNewChatPhoto?.message?.new_chat_photo![0].file_id == "AgADBQADg6wxGxETzQRUve2yEV8EPCPYvTIABOcYQVoTBHauqIgBAAEC")
		XCTAssert(updateNewChatPhoto?.message?.new_chat_photo![1].width == 320)
		XCTAssert(updateNewChatPhoto?.message?.new_chat_photo![2].height == 640)
		XCTAssert(updateNewChatPhoto?.message?.new_chat_photo![3].file_size == 218228)
		
	}

	func testDecodeSticker() {
	
		let updateString = "{\"update_id\":719535949, \"message\":{\"message_id\":36862,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464535464,\"sticker\":{\"width\":512,\"height\":512,\"emoji\":\"\\ud83c\\udf1a\",\"thumb\":{\"file_id\":\"AAQFABOwX74yAASGQuhTuwnfBRsZAAIC\",\"file_size\":1824,\"width\":128,\"height\":128},\"file_id\":\"BQADBQADoAIAAmdqYwQNCKYF4l1v-gI\",\"file_size\":6408}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.sticker?.file_id == "BQADBQADoAIAAmdqYwQNCKYF4l1v-gI")
		XCTAssert(update?.message?.sticker?.width == 512)
		XCTAssert(update?.message?.sticker?.height == 512)
		XCTAssert(update?.message?.sticker?.emoji == "🌚")
		XCTAssert(update?.message?.sticker?.file_size == 6408)
		
		XCTAssert(update?.message?.sticker?.thumb != nil)
		XCTAssert(update?.message?.sticker?.thumb?.file_id == "AAQFABOwX74yAASGQuhTuwnfBRsZAAIC")
		XCTAssert(update?.message?.sticker?.thumb?.width == 128)
		XCTAssert(update?.message?.sticker?.thumb?.height == 128)
		XCTAssert(update?.message?.sticker?.thumb?.file_size == 1824)
		
	}
	
	func testDecodeVideo() {
	
		let updateString = "{\"update_id\":719535951, \"message\":{\"message_id\":36864,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464535853,\"forward_from\":{\"id\":70475313,\"first_name\":\"Jake\",\"last_name\":\"Dai\",\"username\":\"Disaur\"},\"forward_date\":1452045401,\"video\":{\"duration\":2,\"width\":640,\"height\":360,\"thumb\":{\"file_id\":\"AAQDABOs7IYxAAR7gh-hm4O2xHomAAIC\",\"file_size\":1982,\"width\":90,\"height\":49},\"file_id\":\"BAADAwADHQADMV4zBNIlZtWUS2SAAg\",\"file_size\":273282}, \"caption\":\"test\"}}"
	
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.video?.file_id == "BAADAwADHQADMV4zBNIlZtWUS2SAAg")
		XCTAssert(update?.message?.video?.width == 640)
		XCTAssert(update?.message?.video?.height == 360)
		XCTAssert(update?.message?.video?.duration == 2)
		XCTAssert(update?.message?.video?.file_size == 273282)
		XCTAssert(update?.message?.caption == "test")
		
		/* TODO 'mime_type' */
//		XCTAssert(update?.message?.video?.mime_type ==)
		
		XCTAssert(update?.message?.video?.thumb != nil)
		XCTAssert(update?.message?.video?.thumb?.file_id == "AAQDABOs7IYxAAR7gh-hm4O2xHomAAIC")
		XCTAssert(update?.message?.video?.thumb?.width == 90)
		XCTAssert(update?.message?.video?.thumb?.height == 49)
		XCTAssert(update?.message?.video?.thumb?.file_size == 1982)
		
	}
	
	func testDecodeVoice() {
		
		let updateString = "{\"update_id\":719535838, \"message\":{\"message_id\":36750,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464499172,\"voice\":{\"duration\":1,\"mime_type\":\"audio\\/ogg\",\"file_id\":\"AwADBQADMgEAAhETzQStJvo53ZGb2AI\",\"file_size\":8201}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.voice?.file_id == "AwADBQADMgEAAhETzQStJvo53ZGb2AI")
		XCTAssert(update?.message?.voice?.duration == 1)
		XCTAssert(update?.message?.voice?.mime_type == "audio/ogg")
		XCTAssert(update?.message?.voice?.file_size == 8201)
		
	}
	
	func testDecodeContact() {
	
		let updateString = "{\"update_id\":719535963, \"message\":{\"message_id\":36876,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464536877,\"contact\":{\"phone_number\":\"14696423333\",\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"user_id\":80548625}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.contact?.phone_number == "14696423333")
		XCTAssert(update?.message?.contact?.first_name == "Shane")
		XCTAssert(update?.message?.contact?.last_name == "Qi")
		XCTAssert(update?.message?.contact?.user_id == 80548625)
	
	}
	
	func testDecodeLocation() {
	
		let updateString = "{\"update_id\":719535967, \"message\":{\"message_id\":36880,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464537048,\"location\":{\"latitude\":33.001599,\"longitude\":-96.739264}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.location?.longitude == -96.739264)
		XCTAssert(update?.message?.location?.latitude == 33.001599)
	
	}
	
	func testDecodeVenue() {
	
		let updateString = "{\"update_id\":719535974, \"message\":{\"message_id\":36887,\"from\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\"},\"chat\":{\"id\":80548625,\"first_name\":\"Shane\",\"last_name\":\"Qi\",\"username\":\"ShaneQi\",\"type\":\"private\"},\"date\":1464537658,\"location\":{\"latitude\":33.000869,\"longitude\":-96.739769},\"venue\":{\"location\":{\"latitude\":33.000869,\"longitude\":-96.739769},\"title\":\"Estates of Richardson\",\"address\":\"955 W President George Bush Hwy\",\"foursquare_id\":\"56d8a428cd10569560386b1e\"}}}"
		
		let update = ZEGDecoder.decodeUpdate(updateString)
		
		XCTAssert(update?.message?.venue?.title == "Estates of Richardson")
		XCTAssert(update?.message?.venue?.address == "955 W President George Bush Hwy")
		XCTAssert(update?.message?.venue?.foursquare_id == "56d8a428cd10569560386b1e")
		
		XCTAssert(update?.message?.venue?.location != nil)
		
		XCTAssert(update?.message?.venue?.location.longitude == -96.739769)
		XCTAssert(update?.message?.venue?.location.latitude == 33.000869)
		
	}
	
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
	
}
