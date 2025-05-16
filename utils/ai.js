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
    const response = await axios.post(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${this.ai.apiKey}`,
      {
        contents: [
          {
            parts: [{ text: ask }]
          }
        ]
      }
    );

    return response.data.candidates[0].content.parts[0].text;
  }
}

const ai = new AI();
module.exports = ai;
