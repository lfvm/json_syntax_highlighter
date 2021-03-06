"""
Script that reads a json file, and outputs an html that highlihts different tokens of the json 
like keys, values, braces, etc.

20/04/2022

Authors: Fernando Valdeon and Salomon Dabbah

"""


defmodule SyntaxHighlighter do

  def is_blank?(data), do: (is_nil(data) || Regex.match?(~r/\A\s*\z/, data))


  """
    The following function recieves a text, and will use the previous functions to find 
    a token inside the json string, this token can be a key, strign, etc.
    When a match is found, the function will return the html line and the rest of the string
    
    Example:

    "an_important_valuee": "hello world"

    -> ["<span class=\"key\">  "an_important_valuee": </span>", "hello world"]
    -> 
  """
  def matchJson(text) do
    
    cond do


      RegexMatcher.matchObject(text) != nil  ->
        match = RegexMatcher.matchObject(text)
        rest = Regex.replace(~r/\{|\}/,text,"")
        [match, rest]


      RegexMatcher.matchKeys(text) != nil  ->
        match = RegexMatcher.matchKeys(text)
        rest = Regex.replace(~r/"[^"]+"\s*:,?/,text,"")
        [match, rest]

      
      RegexMatcher.matchBracket(text) != nil  ->
        match = RegexMatcher.matchBracket(text)
        rest = Regex.replace(~r/\[|\]/,text,"")
        [match, rest]
        

      RegexMatcher.matchStrings(text) != nil  ->
        match = RegexMatcher.matchStrings(text)
        rest = Regex.replace(~r/".*?"/,text,"")
        [match, rest]
          
      
      RegexMatcher.matchOperators(text) != nil  ->
        match = RegexMatcher.matchOperators(text)
        rest = Regex.replace(~r/true|false|,|null/,text,"")
        [match, rest]
            
            
      RegexMatcher.matchNumbers(text) != nil  ->
        match = RegexMatcher.matchNumbers(text)
        rest = Regex.replace(~r/-?\d+\.?\d*([eE]?[-\+]?\d+)?/,text,"")
        [match, rest]
        

    
    
      true -> IO.puts text


    end
  end



  
  
    """
    Main function of the program, reads each line of the json file and maps it to 
    the function parse_line wich returns the same line but in html format.
  
    Each line will be stored in a list, and after every line is parsed, the list 
    is joined using empty spaces which creates a string containing all the lines.
  
    Finally the result string is appended to an html file which will be the final output 
    """
  def parse_json(in_filename, out_filename) do
    #Reads each line and converts them to html
    lines =
      in_filename
      |> File.stream!()
      |> Enum.map(&parse_line/1)
      |> Enum.join("\n")

    #Get and format current date 
    today = DateTime.utc_now
    date = Enum.join [today.year, today.month, today.day], "/"
    #Result string that will be appended to the html file
    file = """
    <!DOCTYPE html>
    <html>
    <head>
    <title>JSON Code</title>
    <link rel="stylesheet" href="token_colors.css">
    </head>
    <body>
    <h1>JSON Highlighter</h1>
    <h2>Fernando Valdeon, Salomon Dabbah</h2>
    <h3>Date: #{date}</h3>
    <div class="output">
    <h3 id='output'>Output:</h3>
    <pre>
    #{lines}
    </pre>
    </div>
    </body>
    </html>
    """
    #Escribir string en un nuevo archivo 
    File.write(out_filename,file)
  end


  """
    Recursive function that returns a line from the json file formated in html

    Example: "an_important_value": true
    -> "<span class=\"key\">"an_important_value":</span><span class=\"op\"> true </span> 
  """
  def parse_line(line), do: do_parse_line(line ,"",false)
  #Parameters: line, result and if the remaining line is empty or not 

  #Edge cases
  defp do_parse_line("\n",result,_), do: result
  defp do_parse_line(_,result,true), do: result


  defp do_parse_line(line, result,_) do
    data = matchJson(line)
    htmlLine = Enum.at(data,0)
    rest = Enum.at(data,1)
    isBlank = is_blank?(rest)
    do_parse_line(rest, "#{result}#{htmlLine}",isBlank)
    
  end




  def parse_json_concurrent() do 

    """
      The function will read the json files and parse them concurrently, using the file name
      and the output file name as parameters.
    """
    files = [
      "Test_files/example_0.json",
      "Test_files/example_1.json",
      "Test_files/example_2.json",
      "Test_files/example_3.json",
      "Test_files/example_4.json",
      "Test_files/example_5.json",
    ]
    |> Enum.map(&Task.async(fn -> parse_json(&1, "Output_files/concurrent_#{String.slice(&1, 11..19)}.html") end ))
    |> Enum.map(&Task.await(&1))    
  end


  def parse_json_secuential() do 

    """
      The function will read the json files and parse them on by one
    """
    files = [
      "Test_files/example_0.json",
      "Test_files/example_1.json",
      "Test_files/example_2.json",
      "Test_files/example_3.json",
      "Test_files/example_4.json",
      "Test_files/example_5.json",
    ]
    do_parse_json_secuential(files)
  end

  defp do_parse_json_secuential([]), do: IO.puts nil
  defp do_parse_json_secuential([head | tail ]) do 
    parse_json(head, "Output_files/secuential_#{String.slice(head, 11..19)}.html") 
    do_parse_json_secuential(tail)
  end


  def measure(function) do
    #Function that measures execution time of a function
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end


  def main() do
    #Measure execution time of the function parse_json_concurrent and parse_json secuential
    IO.puts "Execution time of concurrent function: #{measure(fn -> parse_json_concurrent() end )}"
    IO.puts "Execution time of secuential function: #{measure(fn -> parse_json_secuential() end )}"

  end


end




SyntaxHighlighter.main()