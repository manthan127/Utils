//
//  ThrowingTask.swift
//  Utils
//
//  Created by Home on 10/05/25.
//

import Foundation
import SwiftUI

typealias throwingTaskResult<Success> = Task<Result<Success, Error>, Never>

@discardableResult
func ThrowingTask<Success>(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Success,
    errorHandler: @escaping (Error)->Void
) -> throwingTaskResult<Success> {
    Task(priority: priority) {
        do {
            return .success(try await operation())
        } catch {
            errorHandler(error)
            return .failure(error)
        }
    }
}

@discardableResult
func ThrowingTaskDetached<Success>(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Success,
    errorHandler: @escaping (Error) -> Void
) -> throwingTaskResult<Success> {
    Task.detached(priority: priority) {
        do {
            return .success(try await operation())
        } catch {
            errorHandler(error)
            return .failure(error)
        }
    }
}

@discardableResult
func ThrowingTask<Success>(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Success,
    typedHandlers: (any AnyErrorHandler)...,
    defaultHandler: @escaping (Error)->Void
) -> throwingTaskResult<Success> {
    Task(priority: priority) {
        do {
            return .success(try await operation())
        } catch {
            for errorHandler in typedHandlers {
                if errorHandler.handle(error) {
                    return .failure(error)
                }
            }
            
            defaultHandler(error)
            return .failure(error)
        }
    }
}

@discardableResult
func ThrowingTaskDetached<Success>(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Success,
    typedHandlers: (any AnyErrorHandler)...,
    defaultHandler: @escaping (Error)->Void
) -> throwingTaskResult<Success> {
    Task.detached(priority: priority) {
        do {
            return .success(try await operation())
        } catch {
            for errorHandler in typedHandlers {
                if errorHandler.handle(error) {
                    return .failure(error)
                }
            }
            
            defaultHandler(error)
            return .failure(error)
        }
    }
}


extension View {
    func throwingTask(
        priority: TaskPriority = .userInitiated,
        _ action: @escaping @Sendable () async throws -> Void,
        errorHandler: @escaping (Error)->Void
    ) -> some View {
        self.task(priority: priority) {
            do {
                try await action()
            } catch {
                errorHandler(error)
            }
        }
    }
    
    func throwingTask(
        priority: TaskPriority = .userInitiated,
        _ action: @escaping @Sendable () async throws -> Void,
        typedHandlers: (any AnyErrorHandler)...,
        errorHandler: @escaping (Error)->Void
    ) -> some View {
        self.task(priority: priority) {
            do {
                try await action()
            } catch {
                for errorHandler in typedHandlers {
                    if errorHandler.handle(error) {
                        return
                    }
                }
                errorHandler(error)
            }
        }
    }
}
