// ai.js
const tf = require('@tensorflow/tfjs-node');

class AI {
  // Google Places API 설정
  //TODO:: DB 연동으로 일 1000회 미만 호출하도록 제한 필요, 이후 호출 시 가격
  GOOGLE_API_KEY = 'AIzaSyCNkyasbk06OrFfuVVdXYIZ1XxFPR3_Ra4'; // Google Places API 키
  BASE_URL = 'https://maps.googleapis.com/maps/api/place/textsearch/json';

  // AI 모델 로드 (가상 예시, 실제로는 학습된 모델을 사용해야 함)
  async loadAIModel() {
    // 여기서는 간단한 모델을 로드하는 예시
    // 실제로는 여행 일정 추천을 위한 모델을 로드해야 함
    const model = await tf.loadLayersModel('file://utils/model.json');
    return model;
  }

  // Google Places API로 관광지 및 관련 장소 검색
  async searchPlaces(city, keyword) {
    const url = `${this.BASE_URL}?query=${keyword}+in+${city}&key=${this.GOOGLE_API_KEY}`;
    try {
      const response = await fetch(url);
    
    // 응답 상태가 200 OK일 경우만 처리
    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    const data = await response.json();  // JSON으로 응답 받기
    return data.results;  // 결과 반환
    } catch (error) {
      console.error('Error fetching places data:', error);
      return [];
    }
  }

  // 여행 일정 추천을 위한 AI 모델을 사용한 함수
  async generateTravelPlan(city, startDate, endDate, keywords) {
    // AI 모델 로드
    const model = await this.loadAIModel();

    // 예시로 AI 모델에 필요한 데이터를 구성 (여기서는 단순히 날짜와 키워드를 텐서로 변환)
    const inputTensor = tf.tensor([startDate, endDate, ...keywords]);
    const predictions = model.predict(inputTensor);

    // 예시로 예측된 여행 일정 (실제로는 AI가 더 복잡한 로직을 수행)
    const itinerary = predictions.dataSync();
    return itinerary;
  }

  // 여행 일정을 생성하는 메인 함수
  async createTravelPlan(city, startDate, endDate, keywords) {
    console.log('여행지:', city);
    console.log('여행 기간:', startDate, '부터', endDate);

    // Google Places API로 각 키워드에 맞는 장소들 검색
    const places = await Promise.all(keywords.map(keyword => this.searchPlaces(city, keyword)));

    // AI 모델로 여행 일정 생성
    const itinerary = await this.generateTravelPlan(city, startDate, endDate, keywords);

    // 여행 일정을 출력
    console.log('추천된 여행 일정:');
    console.log('비행기:', itinerary[0]);
    console.log('도착:', itinerary[1]);
    console.log('축구 경기:', itinerary[2]);
    console.log('관광지:', itinerary[3]);
    console.log('음식점:', itinerary[4]);

    // 추천된 장소 및 액티비티 정보 출력
    places.forEach((placeResults, index) => {
      console.log(`\n${keywords[index]} 관련 장소:`);
      placeResults.forEach(place => {
        console.log(`- ${place.name}: ${place.formatted_address}`);
      });
    });
  }
}

module.exports = new AI();