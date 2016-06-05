# ZEGBotExample

This example project aims to be deployed on **Heroku**. And the example bot has three features:

1. When you send a `"foo"` to the bot, it sends a text message `"bar"` back to you.

2. The bot counts updates it received. When you send a `"/count"`, it reply you how many updates it's got so far.

3. When you send a location replying to your friend's location message in a group, the bot tells you the distance between you two.

![ZEGBotExample](https://raw.githubusercontent.com/ShaneQi/ZEGBot/master/READMEAssets/ZEGBotExampleRules.png)

## Have a Bot

You have to talk to [BotFather](https://telegram.me/botfather) and follow a few simple steps to create your bot. Once you've created a bot and received your authorization token, head down to the next step.

## Before Deployment

Do edit `src/PerfectHandler.swift`.

1. You **have to** Edit `token` String variable to your bot's token. A token should be a String that looks like `123456789:ABCD_RFGHIvJKLM8_wN_OawriyPvfbpQR3S`.

2. Modify rules if you want add/delete features. Where rules are supposed to go is marked by comment in `src/PerfectHandler.swift`.

## Deployment

1. Singup on Heroku and create an app, the app's name will be referred by `[heroku_app_name]`.

1. In app's `Settings` tab, add buildpack: `https://github.com/PerfectlySoft/Perfect-Heroku-Buildpack.git`

1. Download and install [Heroku Toolbelt](https://toolbelt.heroku.com). (details about step 3 - 5 can be found in the `Deploy` tab under your app)

1. Create a new Git repository in `ZEGBotExample` directory:
    ```bash
    $ cd ZEGBotExample/
    $ git init
    $ heroku git:remote -a [heroku_app_name]
    ```

1. Deploy your bot:
    ```bash
    $ git add .
    $ git commit -am "make it better"
    $ git push heroku master
    ```

1. With no issues, it would process for a while then your bot server-side is ready.

## Set Webhook

At last, you have to set a webhook, telling Telegram to send a update to your server every time your bot receives a message.

To set the webhook, just open this url in your browser: `http://api.telegram.org/bot[token]/setWebhook?url=https://[heroku_app_name].herokuapp.com/`

SetWebhook url Example: `https://api.telegram.org/bot123456789:ABCD_RFGHIvJKLM8_wN_OawriyPvfbpQR3S/setWebhook?url=https://zegbotexample.herokuapp.com/`

**Then, go play with your own bot!**
