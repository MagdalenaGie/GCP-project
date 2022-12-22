const IncomingWebhook = require('@slack/webhook').IncomingWebhook;
const url = "https://hooks.slack.com/services/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";
// url.parse(process.env.SLACK_WEBHOOK);
const webhook = new IncomingWebhook(url);

exports.helloPubSub = (message, context) => {
  const msg = Buffer.from(message.data, 'base64').toString()
  const msgObj = JSON.parse(msg)
  const data = msgObj.resource.labels.job_name + ": " + msgObj.textPayload;
  (async () => {
    await webhook.send({
      icon_emoji: ':tada:',
      text: data,
    });
  })();
};