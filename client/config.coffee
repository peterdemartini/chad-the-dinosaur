module.exports =
  GAME:
    RESTITUTION: 0.99
    COF: 0.99
  GRASS:
    UID: 50
    HEIGHT: 100
    FILL_STYLE: '#4F9400'
    TYPE: 'ground'
    START_X: 0
    START_Y: 50
    TREATMENT: 'static'
    BODY_TYPE: 'rectangle'
  SUN:
    BODY_TYPE: 'rectangle'
  SKY:
    BODY_TYPE: 'rectangle'
  CHAD:
    UID: 1
    START_X:50
    MOVE_DELAY: 50
    MOVE_X: 8
    HEIGHT:50
    WIDTH:50
    VX: 0.3
    VY: 0.02
    TYPE:'chad-the-dinosaur'
    RESTITUTION: 1
    COF: 0
    IMAGE_PATH: '/assets/dinosaur.svg'
  ROBOT_CHICKEN:
    START_X:50
    START_Y:50
    HEIGHT: 20
    WIDTH: 20
    VX: -0.1
    VY: 0
    TYPE:'robot-chicken'
    TREATMENT: 'kinematic'
    RESTITUTION: 0
    COF: 1
    IMAGE_PATH: '/assets/robot-chicken.svg'
  ROCKET:
    MOVE_DELAY: 50
    HEIGHT: 10
    WIDTH: 15
    VX: 0.3
    VY: 0
    RESTITUTION: 0
    COF:1
    TREATMENT: 'kinematic'
    TYPE: 'rocket'
    IMAGE_PATH: '/assets/rocket.svg'
