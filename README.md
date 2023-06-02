# README
# 프로젝트 매니저
> 일정을 Todo, Doing, Done 파트로 나누어 관리하는 iPad앱
> 
> 프로젝트 기간: 2023.05.15-2023.06.02
> 

## 개발자

| 리지 |
|  :--------: | 
|<Img src ="https://user-images.githubusercontent.com/114971172/221088543-6f6a8d09-7081-4e61-a54a-77849a102af8.png" width="200" height="200"/>
|[Github Profile](https://github.com/yijiye)


## 목차
1. [타임라인](#타임라인)
2. [프로젝트 구조](#프로젝트-구조)
3. [적용기술](#적용기술)
4. [실행 화면](#실행-화면)
5. [트러블 슈팅](#트러블-슈팅) 
6. [핵심경험](#핵심경험)
7. [참고 링크](#참고-링크)

# 타임라인 

### week1

|    날짜    | 내용 |
|:----:| ---- |
| 2023.05.15 | 적용기술 선정하기 |
| 2023.05.16 | Local, Remote DB 선정, 아키텍쳐, reactive, library 선정 |
| 2023.05.17 | MVVM, Combine 학습, 앱 plus 화면 구현 |
| 2023.05.18 | MVVM, Combine 학습, 앱 메인화면 기본 틀 구현 |
| 2023.05.19 | README 작성, DateFormatManager 구현|

### week2

|    날짜    | 내용 |
|:----:| ---- |
| 2023.05.22 | TableView 기본 구현, ViewModel 구현 |
| 2023.05.23 | Longpress gesture 구현, HeaderView, CircleLabel 구현|
| 2023.05.24 | TableView 이동 로직 리팩토링, Longpree gesture 리팩토링 |
| 2023.05.25 | TableView class로 분리 |
| 2023.05.26 | ViewController, ViewModel 역할 분리|

### week3

|    날짜    | 내용 |
|:----:| ---- |
| 2023.05.29 | ViewController, ViewModel 역할 분리, Autolayout 수정, Edit 모드 리팩토링 |
| 2023.05.30 | PlanSubscriber protocol 구현 |
| 2023.05.31 | TableViewDiffableDataSource, Snapshot 구현 |
| 2023.06.01 | UnitTest |
| 2023.06.02 | UnitTest, PR, README 작성|


<br/>


# 프로젝트 구조

## File Tree
```typescript
ProjectManager
├── .swiftlint
├── ProjectManager
│   ├── Model
│   │   ├── Plan.swift
│   │   ├── DateFormatManager.swift
│   │   └── Tense.swift
│   ├── ViewModel
│   │   ├── State.swift
│   │   ├── PlanSubscriber.swift
│   │   ├── PlanManagerViewModel.swift
│   │   ├── PlanViewModel.swift
│   │   ├── PlusTodoViewModel.swift
│   │   └── PlanTableCellViewModel.swift
│   ├── View
│   │   ├── TextColor.swift
│   │   ├── PlanTableViewCell.swift
│   │   ├── CircleLabel.swift
│   │   └── HeaderView.swift
│   ├── ViewController
│   │   ├── PlanManagerViewController.swift
│   │   ├── PlanViewController.swift
│   │   ├── PlusTodoViewController.swift
│   │   └── SavingItemDelegate.swift
│   ├── Mock
│   │   └── MockPlanSubscriber.swift
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   ├── Assets.xcassets
│   └── LaunchScreen
├── ProjectManagerTests
│   ├── PlanTableCellViewModelTests.swift
│   ├── PlusTodoViewModelTests.swift
│   ├── PlusViewModelTests.swift
└─  └── PlanManagerViewModelTests.swift 
```


 <br/>
 
# 적용기술

| 화면구현 | Local DB | Remote DB | Convention | Reactive | 아키텍쳐 | 의존성 관리도구 |
| -------- | -------- | --------- | ---------- | ------------------ | -------- | --- |
| ✅ UIKit    | Realm    | Firebase  |✅ Swiftlint  |✅ Combine | ✅ MVVM  | Swift Package Manager |

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

<br/>

# 실행 화면



|    항목    |                            실행 화면                             |
|:----------:|:----------------------------------------------------------------:|
| **할 일 저장** | <img src="https://hackmd.io/_uploads/rkEu8gwIh.gif" width="400"> |
| **할 일 이동** | <img src="https://hackmd.io/_uploads/H1t98xPI2.gif" width="400"> |
| **할 일 삭제** | <img src="https://hackmd.io/_uploads/Sysn8lwLn.gif" width="400"> |
|**할 일 수정** | <img src="https://hackmd.io/_uploads/ByAhUgPL2.gif" width="400"> |


<br/>

# 트러블 슈팅

## 1️⃣ ViewController와 ViewModel 세분화

### 🔍 문제점
처음엔 하나의 ViewModel 안에 Todo, Doing, Done 3가지 배열이 존재하고 버튼을 눌렀을 때, 원래의 배열에서 다음 배열로 이동하고 삭제되는 로직으로 구성하였습니다.
여기서 MVVM패턴을 적용하면서 Combine을 조합하여 사용하였고, State를 계속해서 관찰해서 업데이트하는 과정이 굉장히 복잡하고 디버깅하기 어려운 구조로 되어있었습니다. 실제로 잘 작동되다가 클릭한 cell이 아닌 다른 cell이 이동된다던가, 앱이 터지거나 하는 문제가 발생하였습니다.

<img src ="https://hackmd.io/_uploads/Hk3kIRL8h.png" width="400">

- `MainVC` : 하나의 ViewController로 3가지 TableView를 관리
- `ViewModel` : 하나의 ViewModel에서 3가지 배열을 들고있어 관리 


### 🛠️ 해결방법
로직을 단순화하기 위해 `MainVC`안에 들어있는 세부 View를 분리하였습니다. 

<img src="https://hackmd.io/_uploads/ryzgjRIU3.png" width="500">



- `PlanManagerVC` : 3개의 `PlanVC`를 가지고 있고 이에 해당하는 `ViewModel`을 주입시켜준다.
- `PlanVC` : 1개의 `PlanVM`을 가지고 삭제, 변화등 메서드를 상황에 맞는 메서드를 호출한다.
- `PlanVM` : `PlanVC`에서 메서드가 호출되면, 해당 `PassthrougSubject` 타입의 publisher에게 값이 `send`된다.
- `PlanManagerVM` : `PlanVM`의 publisher를 구독하여 변화가 일어날 때 실제 삭제, 변화 기능을 하는 메서드가 호출되어 `TotalPlan` 배열을 관리한다.


## 2️⃣ 변화가 일어난 cell만 업데이트

### 🔍 문제점
viewModel에서 업데이트된 plan배열을 관찰하여 변화가 일어나면 `tableView.reloadData()`를 활용하여 화면을 계속해서 업데이트 해주었습니다.
이렇게 되면 한가지 변경사항만 생겨도 모든 화면을 계속해서 업데이트 해줘야하니 성능문제, 애니메이션이 부자연스러움, 그로인한 사용자경험이 떨어진다는 문제가 발생하였습니다. 이를 해결하기 위해 변화된 cell만 업데이트 되도록 리팩토링을 하였습니다.


기존 코드
```swift
private func bindPlan() {
    viewModel.$plan
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
}
```

### 🛠️ 해결방법

1. 기존 TableViewDataSource를 사용하여 해결 (실패)

기존 코드는 UITableViewDataSource를 사용하여 데이터를 받고 화면을 구성하였고 기존 코드를 최대한 수정하지 않은채 해결하고자 했습니다. 현재 코드의 흐름은 `PlanManagerViewModel`에서 전체 할 일 리스트를 가지고 있고 분리해서 하위 뷰모델인 `PlanViewModel`로 전달해주는데, 하위 뷰모델에서 접근하는 IndexPath 값과 할 일 리스트의 CRUD를 담당하는 전체 배열에서의 IndexPath 값이 일치하지 않아 해결하는데 어려움을 겪었습니다.
또한 변경되는 지점의 IndexPath를 알아내는 것도 사실상 불가능 하였습니다.(어느 시점에서 알아내야 하는지 불분명하기 때문)

2. DiffableDataSource를 활용 (성공)

iOS13 버전 이후부터 사용가능한 `DiffableDataSource`과 현재 데이터 상태를 감지하는 `snapshot`을 적용하여 해결하였습니다. `snapshot`은 `section`과 `item`에 대한 `Unique identifier`가 존재하여 `indexPath`가 아닌 이 `identifier`로 업데이트를 하기 때문에 실시간으로 변화한 cell만 골라서 업데이트를 할 수 있었습니다.


```swift
private func configureTableView() {
    dataSource = UITableViewDiffableDataSource<Section, Plan>(tableView: tableView) { [unowned self] _, indexPath, _ in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PlanTableViewCell else { return UITableViewCell() }
            
        let plan = viewModel.read(at: indexPath)
        cell.configureCell(with: plan)
            
        return cell
    }
}
    
private func createSnapshot(_ plans: [Plan]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Plan>()
        
    snapshot.appendSections([.main])
    snapshot.appendItems(plans)
    dataSource?.apply(snapshot, animatingDifferences: true)
}

private func bindPlan() {
    viewModel.$plan
        .receive(on: DispatchQueue.main)
        .sink { [weak self] plans in
            self?.createSnapshot(plans)
        }
        .store(in: &cancellables)
}
```

<br/>


## 3️⃣ 선택한 cell을 삭제, 업데이트 하는 로직 

### 🔍 문제점
3가지 state를 가진 plan을 하나의 배열로 관리하는데 이 plan의 state만으로 원하는 cell만 삭제하고 업데이트 하는 로직을 구현하는데 많은 오류가 있었습니다.
이를 해결하고자 plan Model에 `UUID()` 값을 가지도록 하여 id를 비교해서 해당 plan을 찾아내는 로직으로 수정하였습니다.

### 🛠️ 해결방법

#### Plan Model 

```swift
struct Plan: Hashable {
    let id: UUID = UUID()
    var title: String
    var body: String
    var date: Date
    var state: State
}
```
- 본인의 `id`를 들고 있도록 구현

#### Delete method

```swift
private func delete(by id: UUID) {
    planList.removeAll { $0.id == id }
}
```

- `id`가 일치한다면 삭제하도록 구현

#### Change method

```swift
private func changeState(plan: Plan, state: State) {
    guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
        
    var plan = planList[index]
    plan.state = state
      
    update(plan)
}
```

- `firstIndex(where:)` 를 사용하여 `id`가 일치하는 것중 첫 번째 Index 값을 꺼내어 전체 배열에서 해당 Index의 plan을 가져온다.
- 가져온 plan의 상태를 새로운 상태로 바꿔준다
- 바뀐 plan을 `update`에 전달한다.

#### Update method

```swift
func update(_ plan: Plan) {
    guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
    self.planList[index] = plan
}
```
- 마찬가지로 `firstIndex(where:)` 를 사용하여 `id`가 일치하는 것중 첫 번째 Index 값을 꺼내어 전체 배열에서 해당 Index의 plan을 가져온다.
- 그 plan을 새로운 plan으로 교체해준다.

## 4️⃣ private method Unit Test

### 🔍 문제점
ViewModel에 대한 Unit Test를 하면서 `PlanManagerViewModel`의 `private` method를 어떻게 테스트하면 좋을지 고민하였습니다.
처음엔 extension에 따로`private` method 에 접근할 수 있는 method를 새로 만드는 방법을 생각하였는데, test를 위한 불필요한 method를 만드는 것이 잘못된 접근이라 생각하여 아래 방법을 사용하였습니다.

### 🛠️ 해결방법

- 테스트 할 객체

```swift
import Foundation
import Combine

final class PlanManagerViewModel {
    @Published var planList: [Plan] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let todoViewModel: PlanSubscriber
    private let doingViewModel: PlanSubscriber
    private let doneViewModel: PlanSubscriber
    
    init(todoViewModel: PlanSubscriber, doingViewModel: PlanSubscriber, doneViewModel: PlanSubscriber) {
        self.todoViewModel = todoViewModel
        self.doingViewModel = doingViewModel
        self.doneViewModel = doneViewModel
        setUpBindings()
    }
    ...
    
    private func bindDelete(subscriber: PlanSubscriber) {
        subscriber.deletePublisher
            .sink { [weak self] plan in
                self?.delete(by: plan.id)
            }
            .store(in: &cancellables)
    }
    
    private func bindChange(subscriber: PlanSubscriber) {
        subscriber.changePublisher
            .sink { [weak self] (plan, state) in
                self?.changeState(plan: plan, state: state)
            }
            .store(in: &cancellables)
    }
    
    private func delete(by id: UUID) {
        planList.removeAll { $0.id == id }
    }
    
    private func changeState(plan: Plan, state: State) {
        guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
        
        var plan = planList[index]
        plan.state = state
      
        update(plan)
    }
}
```

이때, `delete`와 `changeState`메서드의 경우 `private`이 걸려있었지만, `PlanSubscriber` 프로토콜을 채택한 `viewModel`의 `publisher`를 구독하여 변경사항이 생길 때, 실행되도록 구현되어 있음.

따라서 `PlanSubscriber` 프로토콜을 채택한 `MockPlanSubscriber` 객체를 만들어 테스트하였음.

- Mock객체

```swift
import Foundation
import Combine

final class MockPlanSubscriber: PlanSubscriber {
    var plans: [Plan]?
    var deletePublisher = PassthroughSubject<Plan, Never>()
    var changePublisher = PassthroughSubject<(Plan, State), Never>()

    func updatePlan(_ plans: [Plan]) {
        self.plans = plans
    }
}
```

- 테스트 객체

```swift 
import XCTest
@testable import ProjectManager

final class PlanManagerViewModelTests: XCTestCase {
    var sut: PlanManagerViewModel!
    var mockTodoPlanSubscriber: MockPlanSubscriber!
    var mockDoingPlanSubscriber: MockPlanSubscriber!
    var mockDonePlanSubscriber: MockPlanSubscriber!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockTodoPlanSubscriber = MockPlanSubscriber()
        mockDoingPlanSubscriber = MockPlanSubscriber()
        mockDonePlanSubscriber = MockPlanSubscriber()
        
        sut = PlanManagerViewModel(
            todoViewModel: mockTodoPlanSubscriber,
            doingViewModel: mockDoingPlanSubscriber,
            doneViewModel: mockDonePlanSubscriber
        )
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    ...
    func test_mockPlanSubscriber의_deletePublisher에값이들어오면_planList배열에서삭제된다() {
        // given
        let todoPlan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let doingPlan = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .doing)
        let donePlan = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .done)
        
        sut.create(todoPlan)
        sut.create(doingPlan)
        sut.create(donePlan)
        let oldPlans = sut.planList
        
        mockTodoPlanSubscriber.deletePublisher.send(todoPlan)
        mockDoingPlanSubscriber.deletePublisher.send(doingPlan)
        mockDonePlanSubscriber.deletePublisher.send(donePlan)
        
        // when
        let newPlans = sut.planList
        
        // then
        XCTAssertNotEqual(oldPlans, newPlans)
    }
}
```

- `mockTodoPlanSubscriber`  : mock 객체를 주입한 sut를 선언
`mockDoingPlanSubscriber` 
`mockDonePlanSubscriber` 

- `mockTodoPlanSubscriber.deletePublisher.send(todoPlan)` : mock 객체의 publisher에 값을 보냄
- 값이 보내지면 `sut` 객체에서 값의 변화를 감지하여 `delete`메서드가 실행되어 실제 `[Plan]` 배열이 달라져있는지 최종 아웃풋으로 변화 확인


<br/>

# 핵심경험

<details>
<summary><big>✅ Combine </big></summary> 

- [Combine 학습내용](https://github.com/yijiye/TIL-swift-/tree/main/Swift/Combine)
</details> 

<details>
<summary><big>✅ MVVM </big></summary> 

- [MVVM 학습내용](https://github.com/yijiye/TIL-swift-/blob/main/아키텍쳐/MVC%2C%20MVP%2C%20MVVM.md)
</details> 
    
    
<details>
<summary><big>✅ UITableViewDiffableDataSource, Snapshot </big></summary> 
    
- [TableViewDiffableDataSource, Snapshot 학습내용](https://github.com/yijiye/TIL-swift-/blob/main/UIKit/UITableView/UITableViewDiffableDataSource%2C%20Snapshot.md)
    
</details>

<details>
<summary><big>✅ XCTestExpectation </big></summary> 
    
# Combine 프레임워크를 사용한 ViewModel Unit Test하는 방법

publisher에 값을 전달하는 메서드가 실행되었을 때, 값이 제대로 전달되었는지 확인하기 위한 테스트 진행

- 테스트 할 객체

```swift
import Foundation
import Combine

final class PlanViewModel: PlanSubscriber {
    @Published var plan: [Plan] = []
    var deletePublisher = PassthroughSubject<Plan, Never>()
    var changePublisher = PassthroughSubject<(Plan, State), Never>()
    
    private let state: State
    private var cancellables = Set<AnyCancellable>()
    ...
    func delete(_ plan: Plan) {
        deletePublisher.send(plan)
    }
    
    func changeState(plan: Plan, state: State) {
        changePublisher.send((plan, state))
    }
}
```

- 테스트 객체

```swift
import Combine
import XCTest
@testable import ProjectManager

final class PlanViewModelTests: XCTestCase {
    var sut: PlanViewModel!
    var cancellabels = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = PlanViewModel(state: .todo)
        let planA = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let planB = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .todo)
        let planC = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .todo)
        sut.plan = [planA, planB, planC]
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
        cancellabels.forEach { $0.cancel() }
    }
    ...
    func test_delete실행시_deletPublisher에값이전달된다() {
        // given
        let indexPath = IndexPath(row: 1, section: 0)
        let planToDelete = sut.read(at: indexPath)
        let expectation = expectation(description: "delete")
        
        sut.deletePublisher
            .sink { plan in
                XCTAssertEqual(plan, planToDelete)
                expectation.fulfill()
            }
            .store(in: &cancellabels)
        
        // when
        sut.delete(planToDelete)
        
        // then
        waitForExpectations(timeout: 1)
    }
}
```
- `planToDelete` : 삭제할 `Plan`을 꺼내옴
- `expectation` : 비동기 테스트에서 예상되는 결과를 나타내는 `XCTestExpectation` 인스턴스
- `expectation.fulfill()` : sut의 `deletePublisher`를 구독하여 plan이 같은지 비교하고 테스트의 비동기 작업이 완료되면 `fulfill()`을 호출한다.
- `waitForExpectations(timeout: 1)` : 작업이 완료되고 1초동안 기다린 후 처리

    
</details>

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
- [swiftyjimmy - MockTest](http://swiftyjimmy.com/unit-test-mvvm-in-swift/)
- [mildwhale - Xcode비동기테스트](https://mildwhale.tistory.com/31)
            
## 공식 문서
- [Realm - Mock](https://academy.realm.io/kr/posts/making-mock-objects-more-useful-try-swift-2017/)
- [MartinFowler - MockArticle](https://martinfowler.com/articles/mocksArentStubs.html)
- [WWDC Introducing Combine](https://developer.apple.com/videos/play/wwdc2019/722/)
- [AppleDeveloper - Combine](https://developer.apple.com/documentation/combine)
- [AppleDeveloper - Calender compare](https://developer.apple.com/documentation/foundation/calendar/2293166-compare)
- [AppleDeveloper - DatePicker](https://developer.apple.com/documentation/swiftui/datepicker)
- [AppleDeveloper - UIPopoverPresentationController](https://developer.apple.com/documentation/uikit/uipopoverpresentationcontroller)
- [AppleDeveloper - UITableViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource)
- [AppleDeveloper - NSDiffableDataSourceSnapshot](https://developer.apple.com/documentation/uikit/nsdiffabledatasourcesnapshot)
- [AppleDeveloper - XCTestExpectation](https://developer.apple.com/documentation/xctest/xctestexpectation)
    

