class Task {
    String description;
    int id;
    String title;

    Task({this.description, this.id, this.title});

    factory Task.fromJson(Map<String, dynamic> json) {
        return Task(
            description: json['description'], 
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}