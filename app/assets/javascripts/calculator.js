const buttons = document.querySelectorAll('button');
const calculation = document.querySelector('#calculation');
const answer = document.querySelector('#answer');

let input = '',
    lastInput = '',
    isDotted = false,
    displayData = 0,
    ans = 0;

buttons.forEach((btn) => {
  btn.addEventListener('click', (el) => {
    switch (el.target.className) {
      case 'digit':
        if (lastInput === '=') {
          clearAll();
        }
        input += el.target.value;
        lastInput = el.target.value;
        displayData = formatInput(input);
        calculation.textContent = displayData;
        break;
      case 'operator':
        if (input.length < 1 && el.target.value !== '-') {
          console.log('cannot put this operator at the start of the equation');
        } else if (input === '-' && el.target.value !== '-') {
          console.log("Don't do this please");
        } else {
          if (isDotted) {
            isDotted = false;
          }
          if (lastInput === 'X' || lastInput === '+' || lastInput === '/' || lastInput === '-') {
            input = input.slice(0, -1) + el.target.value;
            lastInput = el.target.value;
            displayData = formatInput(input);
            calculation.textContent = displayData;
          } else {
            if (lastInput === '' && el.target.value !== '-') {
              input = 0;
            }
            input += el.target.value;
            lastInput = el.target.value;
            displayData = formatInput(input);
            calculation.textContent = displayData;
          }
        }
        break;
      case 'function':
        if (el.target.id === 'back') {
          if (input.length >= 1) {
            input = input.slice(0, -1);
            lastInput = el.target.value;
            displayData = formatInput(input);
            calculation.textContent = displayData;
          }
          if (input === '') {
            calculation.textContent = 0;
          }
        }
        if (el.target.id === 'ce') {
          input = '';
          calculation.textContent = 0;
        }
        if (el.target.id === 'c') {
          clearAll();
        }
        if (el.target.id === 'dot') {
          if (lastInput === '=') {
            clearAll();
          }
          if (isDotted) {
            console.log('No more dots allowed');
          } else {
            if (lastInput === '' || lastInput === 'X' || lastInput === '/' || lastInput === '+' || lastInput === '-') {
              input += 0;
            }
            input += el.target.value;
            lastInput = el.target.value;
            displayData = formatInput(input);
            calculation.textContent = displayData;
            isDotted = true;
          }
        }
        if (el.target.id === 'equals') {
          calculation.textContent = formatInput(displayData) + ' =';
          compute(input);
          input = ans;
          lastInput = el.target.value;
        }
        break;
      default:
        console.log('woops something went wrong');
        break;
    }
  });
});

function formatInput(str) {
  return str = str.replace(/(?<=\d)([X/+-])(?=\d)/g, ' $1 ');
}

function clearAll() {
  input = '';
  lastInput = '';
  isDotted = false;
  displayData = 0;
  ans = 0;
  calculation.textContent = displayData;
  answer.textContent = ans;
}

// function toggleMathJS() {
//   const switchText = document.querySelector('#switch > span');
//   if (mathJS) {
//     switchText.textContent = 'Pure JS';
//   } else {
//     mathJS = true;
//     switchText.textContent = 'Math.js';
//   }
// }

function compute(str) {
  let current = '',
      array = [];

  for (let i = 0, ch; ch = str.charAt(i); i++) {
    if ('X/+-'.indexOf(ch) > -1) {
      if (current === '' && ch === '-') {
        current = '-';
      } else {
        array.push(parseFloat(current), ch);
        current = '';
      }
    } else {
      current += str.charAt(i);
    }
  }
  if (current !== '') {
    array.push(parseFloat(current));
  }
  operate(array);
}

function operate(equation) {
  let op, result = [],
      operator = [{
        'X': (a, b) => a * b,
        '/': (a, b) => a / b,
      }, {
        '+': (a, b) => a + b,
        '-': (a, b) => a - b
      }];

  for (let i = 0; i < operator.length; i++) {
    for (let j = 0; j < equation.length; j++) {
      if (operator[i][equation[j]]) {
        op = operator[i][equation[j]];
      } else if (op) {
        result[result.length - 1] = op(result[result.length - 1], equation[j]);
        op = null;
      } else {
        result.push(equation[j]);
      }
    }

    // mathJS ? ans = math.format(result[0], { precision: 14 }) : ans = result[0];
    // equation = result;
    // result = [];
  }

  if (equation.length > 1) {
    console.log('Something went wrong');
    return equation;
  } else if (equation[0] === Infinity) {
    alert("I'm afraid I can't let you do that.");
    clearAll();
  } else {
    answer.textContent = ans;
    return ans;
  }
}