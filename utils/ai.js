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
  async runPrompt(start_date, end_date, city) {
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
              parts: [{ text: `${start_date}부터 ${end_date}까지 ${city}로 여행 갈건데, 각 날짜 별 여행지 3개씩 추천해줘. 마지막 날은 2개만 추천해줘. 각 장소 다음에는 enter 처리한 다음에 간단한 설명을 해줘. '도착일-출발일' 만큼 일정만 짜야돼!` }]
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