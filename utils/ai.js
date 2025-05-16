// db.js
require('dotenv').config();
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
    let generatedText = "";
    try {
      const GEMINI_API_URL = `https://generativelanguage.googleapis.com/v1/models/gemini-1.5-pro:generateContent?key=${this.ai.apiKey}`;
      const response = await fetch(GEMINI_API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [{ text: ask }]
            }
          ]
        })
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`HTTP ${response.status}: ${errorText}`);
      }

      const data = await response.json();
      generatedText = data.candidates?.[0]?.content?.parts?.[0]?.text;

      if (generatedText) {
        console.log('Response from Gemini AI:', generatedText);
      } else {
        console.log('No content generated.');
      }
    } catch (error) {
      console.error('Error generating content:', error.message);
    } finally {
      return generatedText;
    }
  }
}

const ai = new AI();
module.exports = ai;
