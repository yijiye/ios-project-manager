# README
# 프로젝트 매니저
> 일정을 Todo, Doing, Done 파트로 나누어 관리하는 앱
> 
> 프로젝트 기간: 2023.05.15-2023.05.19
> 

## 개발자

| 리지 |
|  :--------: | 
|<Img src ="https://user-images.githubusercontent.com/114971172/221088543-6f6a8d09-7081-4e61-a54a-77849a102af8.png" width="200" height="200"/>
|[Github Profile](https://github.com/yijiye)


## 목차
1. [타임라인](#타임라인)
2. [적용기술](#적용기술)
3. [핵심경험](#핵심경험)
4. [참고 링크](#참고-링크)

# 타임라인 

### week1

|    날짜    | 내용 |
|:----:| ---- |
| 2023.05.15 | 적용기술 선정하기 |
| 2023.05.16 | Local, Remote DB 선정, 아키텍쳐, reactive, library 선정 |
| 2023.05.17 | MVVM, Combine 학습, 앱 plus 화면 구현 |
| 2023.05.18 | MVVM, Combine 학습, 앱 메인화면 기본 틀 구현 |
| 2023.05.19 | README 작성|



<br/>
 
# 적용기술

| 화면구현 | Local DB | Remote DB | Convention | Reactive | 아키텍쳐 | 의존성 관리도구 |
| -------- | -------- | --------- | ---------- | ------------------ | -------- | --- |
| UIKit    | Realm    | Firebase  | Swiftlint  | Combine |  MVVM  | Swift Package Manager |

</br>

<details><summary><big> Local DB, Remote DB 선택 이유 </big></summary>

## Local DB

**Realm** 선택


SQLite, CoreData, Realm 3가지의 장단점을 비교하여 Realm을 선택하였습니다. 먼저 SQLite는 하나의 파일로 구성되고 비교적 작은 프로젝트에 맞는 DB이며 확장성이 부족한 단점이 있어 제외하였습니다.
CoreData는 Apple이 지원하는 프레임워크라는 장점이 있었지만 Realm의 데이터를 불러오는 속도가 CoreData보다 빠르고 많은 양의 데이터라도 일정한 속도가 유지된다는 점에서 Realm을 선택하였습니다. 그리고 CoreData는 이전 프로젝트에서 사용경험이 있어 이번 프로젝트에서는 Realm을 학습해보고자 선택하였습니다.

<img src="https://hackmd.io/_uploads/r1CLZUyrh.png" width="400">


<details><summary>SQLite, CoreData, Realm 비교</summary>
    
### SQLite
iOS에서 기본적으로 사용할 수 있는 DB
SQLite로 인해 생성되는 각 데이터베이스는 하나의 파일로 구성되어 관리된다.

- 장점
   - 다양한 운영체제 환경에서 사용할 수 있다.

- 단점
   - 소규모 프로젝트에서 사용되는 데이터베이스로 대규모의 데이터를 처리하는 프로젝트에는 적합하지 않다.
   - 최소한의 구성 및 튜닝 옵션을 제공하므로 하위 호환성에 대한 문제가 발생한다.
   - 관계형 데이터베이스의 제한으로 인해 확장성이 부족하다.

### CoreData
Apple에서 제공하는 프레임워크로 SQLite를 기반으로 한다.

- 장점
   - SQLite보다 더 많은 메모리를 사용하고, 더 많은 저장공간이 필요하며 더 빠르게 저장된 기록을 가져온다.
   - 객체 중심의 데이터베이스로 CoreData 코드를 Realm을 사용하여 리팩토링할 수 있다.

- 단점
   - 많은 메모리를 사용하고 많은 저장공간이 필요하다.
   - 다른 플랫폼의 OS와 공유되지 않는다.
 
### Realm
오픈 소스 라이브러리, 모바일에 최적화된 데이터베이스 라이브러리
데이터 컨테이너 모델을 사용하며 데이터 객체는 realm에 객체로 저장된다. (객체 중심의 데이터베이스)
한번에 하나의 작업만 가능한 싱글 스레드 환경이다.

- 장점
   - 복잡한 Entity에 대한 매핑을 처리할 문제가 없다.
   - 그렇기 때문에 CoreData, SQLite에 비해 속도가 빠르고 성능이 좋다.
   - 데이터 저장에 제한이 없고 무료로 사용가능하다.
   - 대용량의 데이터에도 일관된 속도 및 성능을 유지할 수 있다.
   - Realm Studio 툴이 있어 DB를 시각적으로 확인할 수 있다.
  
- 단점
   - 다양한 쿼리를 지원하지 않는다.
   
 
</details>

## Remote DB

**Firebase**를 선택
Apple 생태계 통합이라는 장점으로 iCloud를 사용할까 고민하였으나 Firebase보다 기능이 제한적이라는 단점이 더 크게 느껴져 다양한 기능을 제공하는 Firebase를 선택하였습니다.

<details><summary>iCloud, Firebase 비교</summary>
    
### Cloudkit
iCloud 서버에 저장하기 위한 Apple 프레임 워크

- 장점
   - 애플을 사용하는 사람에게 편리하다 (Apple 생태계 통합)
   - 사용자 인증 및 데이터 공유

- 단점
   - 기능 제한 : Firebase보다 다양한 기능을 제공하지 않는다. 주로 데이터 저장과 동기화에 초점을 맞춤
   - 플랫폼 제한 : 다른 플랫폼에 애플리케이션을 확장하는 경우 제한이 있다.

### Firebase
구글에서 제공하는 모바일 앱 개발 플랫폼
- 장점
   - 다양한 기능, 실시간 데이터베이스, 사용자 인증, 스토리지, 클라우드 함수 등을 포함
   - 크로스 플랫폼
   - 확장성
- 단점
   - Google에서 제공하기 때문에 Google에 의존해야한다. 그렇기 때문에 다른 클라우드 서비스로 전환하기 어렵다.
    
</details>

</details>

## 고려사항

#### 1️⃣ 하위 버전 호환성에는 문제가 없는가?
**Realm iOS 9, Firebase는 iOS 11(Xcode 13.3.1)** 이상부터 지원하기 때문에 호환성과 관련한 이슈는 없을 것으로 생각됩니다.

<img src="https://hackmd.io/_uploads/rk2ahOxBn.png" width="200">



#### 2️⃣ 안정적으로 운용 가능한가?
**Realm**은 싱글 스레드 모델을 기반으로 동작하여 동시성 관리를 단순화하고 데이터 일관성을 보장합니다.
**Firebase**는 Firebase 고객센터에서 실시간 보고서로 앱에서 발생하는 활동을 모니터링 할 수 있습니다.
[실시간보고서](https://support.google.com/firebase/answer/9271392?hl=ko&ref_topic=6317489&sjid=12853604787559614395-AP)

#### 3️⃣ 미래 지속가능성이 있는가?
**Realm**과 **Firebase**는 각 **MongoDB, Google**에서 제공하는 서비스로  많은 사용자가 있어 미래 지속가능성이 높습니다.

#### 4️⃣ 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
**Realm**의 리스크는 Realm의 장점인 싱글 스레드를 기반으로 한다는 점이 될 것 같습니다. 여러가지 Realm 사용규칙을 참고하여 리스크를 최소화할 수 있을 것 같습니다.
[Realm threading 규칙](https://ali-akhtar.medium.com/concurrency-multi-threading-in-realm-realmswift-part-4-2345deabe512)

#### 5️⃣ 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
Apple의 first-party 라이브러리인 **Swift Package Manager**를 사용하여 관리할 수 있습니다.

#### 6️⃣ 이 앱의 요구기능에 적절한 선택인가?
어떤 앱을 개발하는지 아직 명확하지 않지만 기능 구현에 충분할 것이라 생각됩니다.


## 아키텍쳐와 reactive

여태까지 MVC 패턴을 활용하여 프로젝트를 진행하였는데, 그때마다 View와 ViewController를 완전히 분리하는데 어려움이 있었고, ViewController의 기능이 너무 많아 무거워지는 문제를 겪었습니다. 따라서 이번 프로젝트에서는 **MVVM 패턴**을 구현하여 이문제를 해결해보고자 합니다. 또한 비동기적 프로그래밍을 지원하는 reactive 라이브러리로 **combine**을 활용하여 비동기 작업을 간결하고 효율적이게 작성해보고자 합니다.



# 핵심경험

<details>
<summary><big>✅ Combine </big></summary> 
이번 프로젝트에서 처음 적용해보는 기술이라 기본 개념부터 학습하였습니다.
학습한 자료는 개인 github에 정리하였습니다.
- [Combine 학습내용](https://github.com/yijiye/TIL-swift-/tree/main/Swift/Combine)
</details> 
  
<br/>
    
    
# 참고 링크

## 적용기술 관련 링크
- [LocalDB 비교](https://purple-log.tistory.com/13)
- [Realm](https://realm.io/best-ios-database/)
- [LocalDB 비교 hoBahkiOS.log](https://velog.io/@qudgh849/LocalDB비교-Realm-vs-SQLite-vs-Core-Data)

## 블로그
- [naljin combine](https://sujinnaljin.medium.com/combine-combine-시작하기-ac726ac40b07)
- [dudu combine example](https://velog.io/@aurora_97/Combine-UIKit에서-Combine-편하게-쓰기)
- [zedd combine](https://zeddios.tistory.com/1003)
- [mizzo UILabel padding](https://mizzo-dev.tistory.com/entry/iOSswfit3-Label에-공백간격Padding-적용하기)
            
## 공식 문서
- [WWDC Introducing Combine](https://developer.apple.com/videos/play/wwdc2019/722/)
- [AppleDevelopment - Combine](https://developer.apple.com/documentation/combine)
- [AppleDevelopment - Calender compare](https://developer.apple.com/documentation/foundation/calendar/2293166-compare)

