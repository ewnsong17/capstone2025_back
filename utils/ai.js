// db.js
const config = require('./config');
const { OpenAI } = require('openai');

class AI {
  constructor() {
    this.ai = new OpenAI({
      apiKey: config.ai.api_key,
    });
  }

  // AI 프롬프트
  async runPrompt(ask) {
    const chatCompletion = await this.ai.chat.completions.create({
      messages: [{role: 'user', content: ask}],
      model: 'gpt-3.5-turbo',
    });

    return chatCompletion.choices[0].message.content;
  }
}

const ai = new AI();
module.exports = ai;
