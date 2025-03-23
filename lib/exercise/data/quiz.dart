import 'package:flutter_application/exercise/adding%20state/quiz_with_data.dart';

final Question question1 = Question(
  text: 'What is the highest mountain in the world?',
  answers: [
    Answer(text: 'Mount Kilimanjaro', isCorrect: false),
    Answer(text: 'Mount Everest', isCorrect: true),
    Answer(text: 'Mount Denali', isCorrect: false),
    Answer(text: 'Mont Blanc', isCorrect: false),
  ],
  type: 'single',
);
// Mount Everest, located in the Himalayas, has a peak elevation of 8,848.86 meters (29,031.7 feet) above sea level.

final Question question2 = Question(
  text: 'Which ocean is the deepest?',
  answers: [
    Answer(text: 'Atlantic Ocean', isCorrect: false),
    Answer(text: 'Indian Ocean', isCorrect: false),
    Answer(text: 'Arctic Ocean', isCorrect: false),
    Answer(text: 'Pacific Ocean', isCorrect: true),
  ],
  type: 'single',
);
// The Pacific Ocean is the deepest, containing the Mariana Trench, which has a maximum known depth of approximately 10,935 meters (35,876 feet) at the Challenger Deep.

final Question question3 = Question(
  text: 'Which country has the largest land area?',
  answers: [
    Answer(text: 'United States', isCorrect: false),
    Answer(text: 'China', isCorrect: false),
    Answer(text: 'Canada', isCorrect: false),
    Answer(text: 'Russia', isCorrect: true),
  ],
  type: 'single',
);
// Russia spans over 17 million square kilometers, covering much of northern Asia and parts of Eastern Europe.

final Question question4 = Question(
  text: 'What is the largest desert in the world (by area)?',
  answers: [
    Answer(text: 'Sahara Desert', isCorrect: false),
    Answer(text: 'Arabian Desert', isCorrect: false),
    Answer(text: 'Antarctic Polar Desert', isCorrect: true),
    Answer(text: 'Gobi Desert', isCorrect: false),
  ],
  type: 'single',
);
// The Antarctic Polar Desert is the largest desert, covering the continent of Antarctica with over 14 million square kilometers.

final Question question5 = Question(
  text: 'Which planet is known as the "Red Planet"?',
  answers: [
    Answer(text: 'Venus', isCorrect: false),
    Answer(text: 'Mars', isCorrect: true),
    Answer(text: 'Jupiter', isCorrect: false),
    Answer(text: 'Saturn', isCorrect: false),
  ],
  type: 'single',
);
// Mars appears red due to the iron oxide (rust) on its surface.

final Question question6 = Question(
  text: 'What is the largest continent?',
  answers: [
    Answer(text: 'North America', isCorrect: false),
    Answer(text: 'South America', isCorrect: false),
    Answer(text: 'Africa', isCorrect: false),
    Answer(text: 'Asia', isCorrect: true),
  ],
  type: 'single',
);
// Asia covers approximately 30% of Earth's total land area and is home to about 60% of the world's population.

final Question question7 = Question(
  text: 'Which animal is known as the "King of the Jungle"?',
  answers: [
    Answer(text: 'Elephant', isCorrect: false),
    Answer(text: 'Tiger', isCorrect: false),
    Answer(text: 'Lion', isCorrect: true),
    Answer(text: 'Gorilla', isCorrect: false),
  ],
  type: 'single',
);
// Lions are known for their majestic appearance and social structure, often being the top predators in their habitats.

final Question question8 = Question(
  text: 'What is the capital city of France?',
  answers: [
    Answer(text: 'Rome', isCorrect: false),
    Answer(text: 'Berlin', isCorrect: false),
    Answer(text: 'Madrid', isCorrect: false),
    Answer(text: 'Paris', isCorrect: true),
  ],
  type: 'single',
);
// Paris is the capital and largest city of France, located on the Seine River in the north of the country.

final Question question9 = Question(
  text: 'What is the largest organ in the human body?',
  answers: [
    Answer(text: 'Heart', isCorrect: false),
    Answer(text: 'Liver', isCorrect: false),
    Answer(text: 'Skin', isCorrect: true),
    Answer(text: 'Lungs', isCorrect: false),
  ],
  type: 'single',
);
// The skin is the largest organ, acting as a protective barrier against the external environment.

final Question question10 = Question(
  text: 'Which famous scientist developed the theory of relativity?',
  answers: [
    Answer(text: 'Isaac Newton', isCorrect: false),
    Answer(text: 'Albert Einstein', isCorrect: true),
    Answer(text: 'Galileo Galilei', isCorrect: false),
    Answer(text: 'Stephen Hawking', isCorrect: false),
  ],
  type: 'single',
);
// Albert Einstein published his theory of relativity in two parts: special relativity in 1905 and general relativity in 1915.

List<Question> questionsData = [
  question1,
  question2,
  question3,
  question4,
  question5,
  question6,
  question7,
  question8,
  question9,
  question10,
];
