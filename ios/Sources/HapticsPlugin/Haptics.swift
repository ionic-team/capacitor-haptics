import AudioToolbox
import UIKit
import CoreHaptics

@objc public class Haptics: NSObject {

    var selectionFeedbackGenerator: UISelectionFeedbackGenerator?

    // Reuse and keep the feedback generators in a prepared state. Apple's docs
    // recommend calling prepare() ahead of time so the Taptic Engine does not
    // cold-start on the first impact, which otherwise adds perceptible latency.
    // Generators are lazily created (and prepared) on first use and re-prepared
    // after every event so the next trigger stays warm.
    private lazy var impactGenerators: [UIImpactFeedbackGenerator.FeedbackStyle: UIImpactFeedbackGenerator] = [:]
    private lazy var notificationGenerator: UINotificationFeedbackGenerator = {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        return generator
    }()

    private func impactGenerator(for style: UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator {
        if let generator = impactGenerators[style] {
            return generator
        }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        impactGenerators[style] = generator
        return generator
    }

    @objc public func impact(_ impactStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = impactGenerator(for: impactStyle)
        generator.impactOccurred()
        generator.prepare()
    }

    @objc public func notification(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        notificationGenerator.notificationOccurred(notificationType)
        notificationGenerator.prepare()
    }

    @objc public func selectionStart() {
        self.selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        self.selectionFeedbackGenerator?.prepare()
    }

    @objc public func selectionChanged() {
        if let generator = self.selectionFeedbackGenerator {
            generator.selectionChanged()
            generator.prepare()
        }
    }

    @objc public func selectionEnd() {
        self.selectionFeedbackGenerator = nil
    }

    @objc public func vibrate() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }

    @objc public func vibrate(_ duration: Double) {
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            do {
                let engine = try CHHapticEngine()
                try engine.start()
                engine.resetHandler = { [] in
                    do {
                        try engine.start()
                    } catch {
                        self.vibrate()
                    }
                }
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)

                let continuousEvent = CHHapticEvent(eventType: .hapticContinuous,
                                                    parameters: [intensity, sharpness],
                                                    relativeTime: 0.0,
                                                    duration: duration)
                let pattern = try CHHapticPattern(events: [continuousEvent], parameters: [])
                let player = try engine.makePlayer(with: pattern)

                try player.start(atTime: 0)
            } catch {
                vibrate()
            }
        } else {
            vibrate()
        }
    }
}
