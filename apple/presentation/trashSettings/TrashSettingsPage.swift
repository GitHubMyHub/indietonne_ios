//
//  TrashSettingsPage.swift
//
//  Mirror of Android `presentation/trashSettings/TrashSettings.kt`.
//

import SwiftUI

private let dayOptions: [String] = (0...14).map { d in
    d == 0 ? "am selben Tag" : "\(d) Tag\(d == 1 ? "" : "e")"
}

struct TrashSettingsPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    let placeId: String
    let streetId: String

    @State private var viewModel: TrashSettingsViewModel?
    @State private var alarmEnabled = false
    @State private var notificationEnabled = false
    @State private var selectedDay: String = dayOptions[1]
    @State private var time: Date = Calendar.current.date(
        bySettingHour: 18, minute: 0, second: 0, of: .now
    ) ?? .now
    @State private var selectedFractionIds = Set<String>()

    var body: some View {
        Form {
            Section("Place") {
                if let place = viewModel?.placeState.place {
                    LabeledContent("Name", value: place.name)
                    LabeledContent("ZIP", value: place.zipCodes.joined(separator: ", "))
                } else {
                    HStack { ProgressView(); Text("Loading place…") }
                }
            }

            Section("Reminder") {
                Toggle("Email Benachrichtigung (Bald)", isOn: $alarmEnabled).disabled(true)
                Toggle("Notification", isOn: $notificationEnabled)
                Picker("Vorlaufzeit", selection: $selectedDay) {
                    ForEach(dayOptions, id: \.self) { Text($0) }
                }
                DatePicker("Uhrzeit", selection: $time, displayedComponents: .hourAndMinute)
            }

            Section("Fraktionen") {
                let fractions = viewModel?.placeState.place?.fractions ?? []
                Toggle("Alle", isOn: Binding(
                    get: { !fractions.isEmpty && fractions.allSatisfy { selectedFractionIds.contains($0.id) } },
                    set: { all in
                        if all {
                            selectedFractionIds = Set(fractions.map(\.id))
                        } else {
                            selectedFractionIds.removeAll()
                        }
                    }
                ))
                ForEach(fractions, id: \.id) { f in
                    Toggle(isOn: Binding(
                        get: { selectedFractionIds.contains(f.id) },
                        set: { isOn in
                            if isOn { selectedFractionIds.insert(f.id) }
                            else { selectedFractionIds.remove(f.id) }
                        }
                    )) {
                        HStack {
                            Circle()
                                .fill(.gray.opacity(0.4))
                                .frame(width: 24, height: 24)
                                .overlay(Image(systemName: "trash.fill").font(.caption2).foregroundStyle(.white))
                            Text(f.name)
                        }
                    }
                }
            }

            Section {
                Button {
                    let input = ScheduleAppointmentInput(
                        placeId: placeId,
                        streetId: streetId,
                        fractionIds: Array(selectedFractionIds),
                        previousDays: previousDays(from: selectedDay),
                        time: timeString,
                        alarm: alarmEnabled,
                        notify: notificationEnabled
                    )
                    viewModel?.schedule(input: input)
                } label: {
                    HStack {
                        if viewModel?.appointmentState.isSaving == true {
                            ProgressView().tint(.white)
                        }
                        Image(systemName: "tray.and.arrow.down")
                        Text("Anlegen")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isValid)

                if let msg = viewModel?.appointmentState.error, !msg.isEmpty {
                    Text(msg).foregroundStyle(.red).font(.callout)
                }
            }
        }
        .navigationTitle("Einstellungen")
        .task(id: placeId) {
            if viewModel == nil {
                viewModel = TrashSettingsViewModel(useCase: env.getAppointmentsUseCase)
            }
            viewModel?.loadPlace(id: placeId)
        }
        .onChange(of: viewModel?.appointmentState.didSchedule) { _, scheduled in
            guard scheduled == true else { return }
            path = NavigationPath()
            path.append(AppRoute.scheduleOverview)
        }
    }

    private var isValid: Bool {
        notificationEnabled && !selectedFractionIds.isEmpty
    }

    private var timeString: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: time)
    }

    private func previousDays(from label: String) -> Int {
        if label == "am selben Tag" { return 0 }
        return Int(label.split(separator: " ").first ?? "0") ?? 0
    }
}
