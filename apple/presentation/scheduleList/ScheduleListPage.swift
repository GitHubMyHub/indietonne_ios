//
//  ScheduleListPage.swift
//
//  Detail-Liste aller Termine eines AppointmentGroup. Gruppiert nach Monat.
//  Mirror of Android `presentation/scheduleList/ScheduleList.kt`.
//

import SwiftUI

struct ScheduleListPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    let appointmentId: String

    @State private var viewModel: ScheduleViewModel?

    private static let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "de_DE")
        f.dateFormat = "LLLL"
        return f
    }()

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy HH:mm"
        return f
    }()

    var body: some View {
        List {
            ForEach(categorized, id: \.title) { section in
                Section(section.title) {
                    ForEach(section.items) { appt in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                ForEach(appt.fractions, id: \.id) { f in
                                    Circle()
                                        .fill(.gray.opacity(0.4))
                                        .frame(width: 22, height: 22)
                                        .overlay(Image(systemName: "trash.fill")
                                            .font(.caption2)
                                            .foregroundStyle(.white))
                                }
                                Text("Intervall Wochen").font(.body)
                            }
                            HStack {
                                Text("Benachrichtigung:").foregroundStyle(.secondary)
                                Spacer()
                                Text(Self.dateFormatter.string(from: appt.scheduledDate ?? appt.appointmentDate))
                            }
                            .font(.callout)
                            HStack {
                                Text("Abfuhrtermin:").foregroundStyle(.secondary)
                                Spacer()
                                Text(Self.dateFormatter.string(from: appt.appointmentDate))
                            }
                            .font(.callout)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("")
        .task {
            if viewModel == nil {
                viewModel = ScheduleViewModel(useCase: env.getAppointmentsUseCase)
                viewModel?.onAction(.load)
            }
        }
    }

    private var group: AppointmentGroupDTO? {
        viewModel?.state.appointments.first { $0.id == appointmentId }
    }

    private var categorized: [Category<AppointmentDTO>] {
        guard let group else { return [] }
        let groups = Dictionary(grouping: group.appointments) {
            Self.monthFormatter.string(from: $0.appointmentDate)
        }
        return groups
            .map { Category(title: $0.key, items: $0.value.sorted { $0.appointmentDate < $1.appointmentDate }) }
            .sorted { $0.title < $1.title }
    }
}
