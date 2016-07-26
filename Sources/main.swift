let zegbot = ZEGBot(token: "229521725:AAHM_LCcQ1vT3hV8_wP_YawriyBvfbpJN3A")

class MyHandler: ZEGHandler {
        
        func handle(_ update: Update) { 
                print(update)         
        }

}

zegbot.runWith(handler: MyHandler())
