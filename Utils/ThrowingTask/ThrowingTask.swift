//
//  ThrowingTask.swift
//  Utils
//
//  Created by Home on 10/05/25.
//

import Foundation

@discardableResult
func ThrowingTask<Success>(
    priority: TaskPriority? = nil,
    operation: @escaping @Sendable () async throws -> Success,
    errorHandler: @escaping (Error)->Void
) -> Task<Result<Success, Error>, Never> {
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
) -> Task<Result<Success, Error>, Never> {
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
) -> Task<Result<Success, Error>, Never> {
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
) -> Task<Result<Success, Error>, Never> {
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
