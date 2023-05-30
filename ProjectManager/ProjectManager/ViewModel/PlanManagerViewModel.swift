//
//  PlanManagerViewModel.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/25.
//

import Foundation
import Combine

final class PlanManagerViewModel {
    @Published var planList: [Plan] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let todoViewModel: PlanViewModel
    private let doingViewModel: PlanViewModel
    private let doneViewModel: PlanViewModel
    
    init(todoViewModel: PlanViewModel, doingViewModel: PlanViewModel, doneViewModel: PlanViewModel) {
        self.todoViewModel = todoViewModel
        self.doingViewModel = doingViewModel
        self.doneViewModel = doneViewModel
        setUpBindings()
    }
    
    private func setUpBindings() {
        bindItem()
        bindDelete()
        bindChange()
    }
    
    private func bindItem() {
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .todo
                }
            }
            .assign(to: \.plan, on: todoViewModel)
            .store(in: &cancellables)
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .doing
                }
            }
            .assign(to: \.plan, on: doingViewModel)
            .store(in: &cancellables)
        $planList
            .map { plans in
                plans.filter { plan in
                    plan.state == .done
                }
            }
            .assign(to: \.plan, on: doneViewModel)
            .store(in: &cancellables)
    }
    
    private func bindDelete() {
        bindDelete(subscriber: todoViewModel)
        bindDelete(subscriber: doingViewModel)
        bindDelete(subscriber: doneViewModel)
    }
    
    private func bindChange() {
        bindChange(subscriber: todoViewModel)
        bindChange(subscriber: doingViewModel)
        bindChange(subscriber: doneViewModel)
    }
    
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

extension PlanManagerViewModel {
    func create(_ plan: Plan) {
        planList.append(plan)
    }
    
    func update(_ plan: Plan) {
        guard let index = self.planList.firstIndex(where: { $0.id == plan.id }) else { return }
        self.planList[index] = plan
    }
}
