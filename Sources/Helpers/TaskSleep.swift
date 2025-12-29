import SwiftUI

public struct TaskSleep: Sendable {
  private let sleep: @Sendable (UInt64) async -> Void

  public init(_ sleep: @escaping @Sendable (UInt64) async -> Void) {
    self.sleep = sleep 
  }

  public func callAsFunction(nanoseconds: UInt64) async {
    await sleep(nanoseconds)
  }
} 

public extension TaskSleep {
  static let noop = Self { _ in }
}

private enum TaskSleepKey: EnvironmentKey {
  static var defaultValue = TaskSleep { try? await Task.sleep(nanoseconds: $0) }
} 

public extension EnvironmentValues {
  var sleep: TaskSleep {
    get { self[TaskSleepKey.self] }
    set { self[TaskSleepKey.self] = newValue }
  }
}
