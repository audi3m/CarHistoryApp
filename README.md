## 프로젝트 소개
- 내 차량을 등록하고 주유, 정비 등의 기록을 저장하고 연도별, 월별로 통계를 볼 수 있는 앱
  
|1. 홈 화면 | 2. 연도별 기록 | 3. 주변 업장 검색 |
| -- | -- | -- |
| <img width="200" src="https://github.com/user-attachments/assets/98d8e6b0-ea3e-4f04-bc77-d2163df41dfa" /> | <img width="200" src="https://github.com/user-attachments/assets/f53880bc-10ce-4c59-9fcd-acd31e184935" /> | <img width="200" src="https://github.com/user-attachments/assets/840f13ee-ac64-47ae-90db-fc0d623fa57a" /> |
</br>

## 프로젝트 정보
- 개발 기간
  - 1차: 2024.09.13 ~ 2024.10.03
- 개발 인원: 1인
- 지원 버전: iOS 17.0+
- 기술 스택 & 라이브러리
  - UI: SwiftUI
  - Data: Realm
  - 기타 기능
    - 위치: MapKit
    - 차량사진: PhotosUI
- 앱 주요 기능
  - 차량 등록, 차량에 대한 기록 저장
  - 주변 차량 관련 업장 검색

</br>

## 프로젝트에서 고민한 것
  - UI/UX
    - 차량 선택
      - 마지막으로 선택한 차량을 저장하고, 앱 실행 시 해당 차량으로 
      - 등록된 차량이 없을 경우, 새로운 차량을 등록하도록 유도
  - 데이터가 추가/삭제 되었을 때 모든 뷰에 바로 적용
  - 메모리 관리
</br>

## 트러블 슈팅
- 선택한 차량의 기록 List&lt;CarLog&gt;가 변하여도 리스트가 업데이트 되지 않음
  ```swift
  @State private var selectedCar: Car?
  ```
  선택한 차량의 log가 추가, 삭제 되었을 때 UI 변화가 없음
  selectedCar 자체가 바뀌었을 때 적용 -> 속성이 바뀌
- Car log 데이터 관리 모델
  - ㅇㅇ
- 지도 화면 백그라운드 UI 오류
  - ㅇㅇ

## 회고
