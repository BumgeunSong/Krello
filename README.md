# Krello

![iOS 13.0+](https://img.shields.io/badge/iOS-13.0%2B-lightgrey) ![Xcode 13.3](https://img.shields.io/badge/Xcode-13.3-blue)

> Trello-style Task Management App
>
> 프로젝트에 대한 자세한 내용은 [👉 Notion](https://cookie-giant-a00.notion.site/Team-KRE-Krello-4a6dfb5c5ccb4e19bd2f2d3fe066f57a) 에서 확인할 수 있습니다

## 앱 소개

[Trello](https://trello.com/) 의 기능을 따라 할일을 관리하는 iOS Application을 만들어 보았습니다.
구현된 기능은 다음과 같습니다:

- 회원 가입과 로그인 기능 구현
- CRUD 중 Read 구현

|                                                                                                                             로그인                                                                                                                             |                                                                                               회원가입                                                                                               |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                          <img src="https://user-images.githubusercontent.com/12508578/169458093-d3af10aa-0eb4-40df-ae8a-e8b0241e3e20.png" width="318" height="562"/>                                                           |                                           ![signup](https://user-images.githubusercontent.com/12508578/169457888-b24c62fc-9301-4a28-aa0e-081f79b083c3.gif)                                           |
| - Firebase authentication 을 사용해 email 로그인을 할 수 있습니다. <br/>- 로그인을 하면 firebase 로 부터 인증을 하고 받아온 사용자 uid 를 local 에 저장해 API 호출에 사용합니다. <br/>- 한번 로그인을 하면 앱 종료 후 다시 실행해도 로그인 상태를 유지합니다. | - email, password 로 회원가입을 할 수 있습니다. <br/>- 입력값에 대한 검증을 하고 유효한 값인지 체크합니다. <br/>- 모든 TextField 의 값이 유효하다고 판단이 되면 비로소 회원가입 버튼이 활성화됩니다. |

|                                                    할일 관리                                                    |                                                   드래그 앤 드랍                                                   |
| :-------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------: |
| ![Board](https://user-images.githubusercontent.com/12508578/169457961-67a38d95-2543-407d-9671-280d22231747.gif) | ![TaskMove](https://user-images.githubusercontent.com/12508578/169458030-758b38a1-2583-497b-a035-d7bdd2a3ad3e.gif) |
|                - 사용자 키(uid) 에 해당하는 데이터를 firestore 로 부터 불러와 화면에 보여줍니다.                |                 - Drag & Drop 으로 할일을 이동시킬 수 있습니다.(서버에 반영하는 작업은 구현 안됨)                  |


### 팀원

| [@Eddy](https://github.com/BumgeunSong)                                                    | [@Kai](https://github.com/TaeKyeongKim)                                                    | [@Rosa](https://github.com/Jinsujin)                                                       |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| <img src="https://avatars.githubusercontent.com/u/17468015?v=4" width="200" height="200"/> | <img src="https://avatars.githubusercontent.com/u/36659877?v=4" width="200" height="200"/> | <img src="https://avatars.githubusercontent.com/u/12508578?v=4" width="200" height="200"/> |
|[👉 프로젝트 회고](https://github.com/BumgeunSong/Krello/wiki/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9A%8C%EA%B3%A0:-@Eddy)                                                                               | [👉 프로젝트 회고](https://github.com/BumgeunSong/Krello/wiki/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9A%8C%EA%B3%A0:-@Kai)                                                                                   | [👉 프로젝트 회고](https://github.com/BumgeunSong/Krello/wiki/%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9A%8C%EA%B3%A0:-@Rosa)                                                                                   |


<br/>

### 사용한 기술

- Unit Test
- View
  - Autolayout programmatically
  - Compositional Layout
- Firebase: Authentication & Storage
- Coordinator pattern

### Library

|                        | Version |           |
| ---------------------- | ------- | --------- |
| SwiftLint              |         | CocoaPods |
| FirebaseAuth           | 9.0.0   | CocoaPods |
| FirebaseFirestore      | 9.0.0   | CocoaPods |
| FirebaseFirestoreSwift | 9.0.0   | CocoaPods |
