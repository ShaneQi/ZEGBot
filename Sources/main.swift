let zegbot = ZEGBot(token: secret)

struct MyHandler: ZEGHandler {
	
	func handle(_ update: Update) {
		print(update)
	}
	
}

zegbot.run(with: MyHandler())

