import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var statusMessage = "Tap Authenticate to test Face ID / Touch ID / passcode."
    @State private var isUnlocked = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: isUnlocked ? "lock.open.fill" : "lock.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(isUnlocked ? .green : .secondary)

                Text(isUnlocked ? "Secure area unlocked" : "Secure area locked")
                    .font(.title3.weight(.semibold))

                Text(statusMessage)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                Button("Authenticate", action: authenticate)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)

                if isUnlocked {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Protected Notes")
                            .font(.headline)
                        Text("This content appears only after successful local authentication.")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 24)
            .navigationTitle("LocalAuthentication")
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                lockSessionForBackground()
            }
        }
    }

    private func authenticate() {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            statusMessage = error?.localizedDescription ?? "Authentication is not available on this device."
            isUnlocked = false
            return
        }

        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock the secure area.") { success, authError in
            DispatchQueue.main.async {
                if success {
                    isUnlocked = true
                    statusMessage = "Authentication succeeded."
                } else {
                    isUnlocked = false
                    statusMessage = authError?.localizedDescription ?? "Authentication failed."
                }
            }
        }
    }

    private func lockSessionForBackground() {
        isUnlocked = false
        statusMessage = "Session locked in background. Authenticate again to continue."
    }
}

#Preview {
    ContentView()
}
