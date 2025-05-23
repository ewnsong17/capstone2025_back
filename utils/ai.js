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
  async runPrompt(start_date, end_date, city, taste) {
    let generatedText = "";
    try {
      let text = '';
      if (start_date == end_date) {
        text = `${start_date}에 ${city}로 여행 갈건데, 여행지 3개 추천해줘. 나는 ${taste} 여행을 원해.`;
      } else {
        text = `${start_date}부터 ${end_date}까지 ${city}로 여행 갈건데, 날짜 별 여행지 3개씩 추천해줘. 마지막 날은 2개만 추천해줘. 나는 ${taste} 여행을 원해.`;
      }

      text += ' 여행지 별 설명은 1줄정도로 해주고, 추가 요청은 안받아도 돼.';

      const GEMINI_API_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro-preview-03-25:generateContent?key=${this.ai.apiKey}`;
      const response = await fetch(GEMINI_API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [{ text: text }]
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
