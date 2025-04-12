struct ListRowView: View {
    
    let title: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "\(title.first?.lowercased() ?? "").circle.fill")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.teal)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.body.weight(.black))
                        .foregroundStyle(.black)
                    Text("Today")
                        .font(.caption.weight(.thin))
                        .foregroundStyle(.black)
                }
                .padding(.leading, 5)
                Spacer()
            }
            .frame(height: 50)
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
        }
        .padding(.horizontal, 20)
    }
}

struct SimpleList: View {
    
    let items: [String] = ["Apple", "Google", "Facebook", "Amazon", "Netflix", "LG", "Sony"]
    
    var body: some View {
        ScrollView {
            ForEach(items, id: \.count) { item in
                ListRowView(title: item)
            }
        }
    }
}

#Preview {
    SimpleList()
}
