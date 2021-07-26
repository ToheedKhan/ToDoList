class Task {
  // Class properties
  String _name;
  bool _completed = false;

  // Default constructor
  Task(this._name);
  // Task(this._name, this._completed);
  // Getter and setter for name
  getName() => this._name;
  setName(name) => this._name = name;

  // Getter and setter for completed
  isCompleted() => this._completed;
  setCompleted(completed) => this._completed = completed;
}
