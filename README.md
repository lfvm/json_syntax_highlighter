
# JSON Syntax Highlighter

Script that reads a json file, and outputs an html that highlihts different tokens of the json 
like keys, values, braces, etc.     
The html output will look like the following picture:

<img width="1400" alt="Captura de Pantalla 2022-05-19 a la(s) 12 38 46" src="https://user-images.githubusercontent.com/57450093/169363163-edac3b4b-ad44-4bed-bcc7-864aef15a589.png">

## How does the algorithm works?

To parse a json document, the algorithm most be able to recognize different tokens that represents its content, in our case,
the tokens used for this project are the following:

- Number - a symbol that expresses a float or an interger

- Operator - the symbols that we use to make arithmetic operations

- Bracket - the symbols that are used for separation '[ ]'

- Key - it is a piece of information that is used for retrieving some data

- String - a combination of letters that conform words

- Object -  Symbols used to represent a js object '{ }'

In order to do this parsing, the script analizes every line of the file, and uses regular expressions to find the previous tokens, then the line will be formated as an html string, for example:

```bash
  "hello": "world"
```
will be transdormed into:

```bash
   <span class="key">"hello":</span><span class="string">"world"</span>
```

finally the line will be inserted into an output html file which has a linked css sheet that stablishes different colors for each span class

### Algorithm time and space complexity:

The algorith uses recursion, this means that more memory will be used when te program is runed.
Since the progrm needs to parse every line from the json file, the space complexity would be: O(n),
n being the number of lines of the file.

And the time complexity will depend on the number of lines inside the file as well as the lenght of each line,
that would be O(n * l), n
being the number of lines and l being the lenght of each line.



## Conclutions

The algorithm has room for improvement, specially, the time complexity could be reduced if loops where used instead of recurssion, however, using recursion makes the code a lot more simple and easy to read. 

As we have seen throughout history, technology has had some major consequences and ethical implications for the human race, and we, as software engineers, need to keep a good ethical record for the wellbeing of our careers and the
safeguarding of the technology we are creating.
This project is not the exception, though this may be seen as a small program with no ethical consequences, it actually has some moral questions and ethic dilemmas to be resolved.
A small example to illustrate this could be that if this simple tool for syntax highlighting got on the wrong hands it could be potentially dangerous, people could use it to program their own malware and affect others through our own code. We think the solution to all these ethical dilemmas would be to protect the code and not make it accessible to all. By making sure to only give code accessibility to the people of who we are certain that will put the code to good use.


## Installation

Download this github repository and run the
following command:

```bash
  mix
```

This will output an html fill inside your root folder.



