// ----------------------------------------------------------------------------
//
//  TaskQueue.swift
//
//  @author     Denis Kolyasev <KolyasevDA@ekassir.com>
//  @copyright  Copyright (c) 2016, eKassir Ltd. All rights reserved.
//  @link       http://www.ekassir.com/
//
// ----------------------------------------------------------------------------

import Atomic
import Foundation
import SwiftCommons

// ----------------------------------------------------------------------------

public class TaskQueue: NonCreatable
{
// MARK: - Functions

    public static func enqueue<Ti, To>(task: Task<Ti, To>) -> Cancellable {
        return enqueue(task, callback: nil)
    }

    public static func enqueue<Ti, To>(task: Task<Ti, To>, callback: Callback<Ti, To>?) -> Cancellable {
        return enqueue(task, callback: callback, callbackOnUiThread: NSThread.isMainThread())
    }

    public static func enqueue<Ti, To>(task: Task<Ti, To>, callback: Callback<Ti, To>?, callbackOnUiThread: Bool) -> Cancellable
    {
        let innerTask = InnerTask(task: task, callback: callback, callbackOnUiThread: callbackOnUiThread)
        self.tasks.withValue { tasks in
            tasks.add(innerTask, key: task.getTag())
        }

        // Execute the task on the background thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
            innerTask.execute()

            self.tasks.withValue { tasks in
                tasks.remove(task.getTag(), value: innerTask)
            }
        }

        // Done
        return innerTask
    }

    public static func cancel(tag: String)
    {
        let cancelledTasks = self.tasks.withValue { tasks in
            return tasks.remove(tag)
        }

        for task in cancelledTasks {
            task.cancel()
        }
    }

// MARK: - Variables

    private static let tasks = Atomic(MultiValueDictionary<String, Cancellable>())

}

// ----------------------------------------------------------------------------

private final class InnerTask<Ti, To>: Cancellable
{
// MARK: - Construction

    init(task: Task<Ti, To>, callback: Callback<Ti, To>?, callbackOnUiThread: Bool)
    {
        // Init instance variables
        self.task = task.clone()
        self.callback = InnerCallback(callback: callback, callbackOnUiThread: callbackOnUiThread)
    }

// MARK: - Functions

    func execute() {
        self.task.execute(self.callback)
    }

    func cancel() -> Bool {
        return self.callback.cancel(self.task)
    }

// MARK: - Variables

    private let task: Task<Ti, To>

    private let callback: InnerCallback<Ti, To>

}

// ----------------------------------------------------------------------------

private final class InnerCallback<Ti, To>: CallbackDecorator<Ti, To>
{
// MARK: - Construction

    init(callback: Callback<Ti, To>?, callbackOnUiThread: Bool)
    {
        // Init instance variables
        self.queue = callbackOnUiThread ?
                dispatch_get_main_queue() :
                dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        // Parent processing
        super.init(callback: callback ?? CallbackDecorator())
    }

// MARK: - Functions

    override func onShouldExecute(call: Call<Ti>) -> Bool
    {
        guard !(self.done.value) else { return false }

        var result = false

        dispatch_sync(self.queue) {
            result = super.onShouldExecute(call)
        }

        return result
    }

    override func onResponse(call: Call<Ti>, entity: ResponseEntity<To>)
    {
        guard !(self.done.swap(true)) else { return }

        dispatch_async(self.queue) {
            super.onResponse(call, entity: entity)
        }
    }

    override func onFailure(call: Call<Ti>, error: RestApiError)
    {
        guard !(self.done.swap(true)) else { return }

        dispatch_async(self.queue) {
            super.onFailure(call, error: error)
        }
    }

    override func onCancel(call: Call<Ti>)
    {
        guard !(self.done.swap(true)) else { return }

        dispatch_async(self.queue) {
            super.onCancel(call)
        }
    }

    func cancel(call: Call<Ti>) -> Bool
    {
        let result = !self.done.swap(true)

        if result
        {
            (call as? Cancellable)?.cancel()

            dispatch_async(self.queue) {
                super.onCancel(call)
            }
        }

        return result
    }

// MARK: - Variables

    private let queue: dispatch_queue_t

    private let done = Atomic<Bool>(false)

}

// ----------------------------------------------------------------------------
