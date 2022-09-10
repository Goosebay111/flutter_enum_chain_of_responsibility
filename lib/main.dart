void main() {
  /*var baseGear = IncreasingGears(Engine.error, null);
  var fifthGear = IncreasingGears(Engine.fifth, baseGear);
  var fourthGear = IncreasingGears(Engine.fourth, fifthGear);
  var thirdGear = IncreasingGears(Engine.third, fourthGear);
  var secondGear = IncreasingGears(Engine.second, thirdGear);
  var firstGear = IncreasingGears(Engine.first, secondGear);*/

  DrivingLogic drivingLogic = Engine.values.reversed.fold(
      IncreasingGears(Engine.error, null),
      (previous, next) => IncreasingGears(next, previous));

  ChangingGears chain = ChangingGears(chain: drivingLogic);
  chain.getIntoGear(Engine.fifth);
}

void isInGear(Engine ourGear, Engine passedGear) {
  getToSpeed(passedGear);
  print('Engine: is in ${ourGear.name} gear');
}

void getToSpeed(Engine passedGear) {
  print('Engine: shifted to ${passedGear.name}.');
  print('accelerated to: ${passedGear.speed} units.');
}

enum Engine {
  first(10, isInGear, getToSpeed),
  second(20, isInGear, getToSpeed),
  third(30, isInGear, getToSpeed),
  fourth(40, isInGear, getToSpeed),
  fifth(50, isInGear, getToSpeed),
  error(0, isInGear, getToSpeed);

  const Engine(this.speed, this.isGear, this.notGear);
  final int speed;

  final Function isGear;
  final Function notGear;
}

class ChangingGears {
  ChangingGears({required this.chain});

  DrivingLogic chain;

  void getIntoGear(Engine setGear) => chain.drive(setGear);
}

abstract class DrivingLogic {
  DrivingLogic(this.nextGear, this.engine);

  final DrivingLogic? nextGear;
  final Engine engine;

/* if the passed gear is null then the chain is broken */
  void drive(Engine gear) => nextGear?.drive(gear);
}

class IncreasingGears extends DrivingLogic {
  IncreasingGears(Engine engine, DrivingLogic? nextGear)
      : super(nextGear, engine);
  @override
  void drive(Engine gear) {
    /* concrete logic is handled here for accelerating and getting to gear */
    if (gear == engine) {
      engine.isGear(engine, gear);
      return;
    }
    engine.notGear(engine);

    /* goes to the next gear in the chain */
    super.drive(gear);
  }
}
