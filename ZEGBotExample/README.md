# ZEGBotExample

This example project aims to be deployed on **Heroku**. And the example bot only has two rules:

1. When you send a `"foo"` to the bot, it sends a text message `"bar"` back to you.
2. The bot counts updates it received. When you send a `"/count"`, it reply you how many updates it's got so far.

![ZEGBotExample](https://raw.githubusercontent.com/ShaneQi/ZEGBot/master/Res/ZEGBotExampleRules.png)

## Before Deployment

Only one single thing: Editing `src/PerfectHandler.swift`.

1. You **have to** Edit `token` String variable to your bot's token. A token should be a String that looks like `123456789:ABCD_RFGHIvJKLM8_wN_OawriyPvfbpQR3S`.

2. Modify rules if you want add/delete features. The rules block is marked by comment in `src/PerfectHandler.swift`.

## Deployment

1. Singup on Heroku and create an app, the app's name will be used below by `[heroku_app_name]`.

2. In app's settings tab, add buildpack: `https://github.com/PerfectlySoft/Perfect-Heroku-Buildpack.git`

3. Download and install the Heroku Toolbelt. (details about step 3 - 5 can be found in the `Deploy` tab under your app)

3. Create a new Git repository:
```bash
$ cd ZEGBotExample/
$ git init
$ heroku git:remote -a [heroku_app_name]
```

4. Deploy your application:
```bash
$ git add .
$ git commit -am "make it better"
$ git push heroku master
```

5. If no issues, it would process for a little then your bot server-side is ready.

## Set Webhook

Open setWebhook url in your browser: `http://api.telegram.org/bot[token]/setWebhook?url=https://[heroku_app_name].herokuapp.com/`

SetWebhook url Example: `https://api.telegram.org/bot123456789:ABCD_RFGHIvJKLM8_wN_OawriyPvfbpQR3S/setWebhook?url=https://zegbotexample.herokuapp.com/`
