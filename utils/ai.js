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
      let text = "";

      if (start_date === end_date) {
        text = `${start_date}에 ${city}로 여행을 갑니다.`;
        text += `\n이 날짜에 방문할 수 있는 여행지를 3곳 추천해 주세요.`;
      } else {
        text = `${start_date}부터 ${end_date}까지 ${city}로 여행을 갑니다.`;
        text += `\n각 날짜별로 3개의 여행지를 추천해 주세요. 마지막 날은 2곳만 추천해 주세요.`;
      }

      text += `\n\n여행지 설명은 한 줄 정도로 짧게 해주세요. 그리고 아래 형식을 반드시 지켜 주세요:\n`;
      text += `\n**YYYY-MM-DD (n일차)**\n**장소명1**\n- 설명\n**장소명2**\n- 설명\n...`;

      text += `\n\n장소명과 날짜는 반드시 위 형식처럼 **별표 두 개**로 감싸 주세요.`;
      text += `특히 마지막 날은 아래처럼 작성해 주세요:`
      text += `## 마지막 날`
      text += `**YYYY-MM-DD (마지막날)**`
      text += `**장소명1**`
      text += `-설명`
      text += `**장소명2**`
      text += `-설명`
      text += `\n사용자의 취향은 '${taste}'입니다.`;

      const GEMINI_API_URL = `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-pro-preview-03-25:generateContent?key=${this.ai.apiKey}`;

      const response = await fetch(GEMINI_API_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [{ text: text }],
            },
          ],
        }),
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
