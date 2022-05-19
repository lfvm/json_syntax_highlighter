
"""
these functions are capable of identifing a token inside a json file using regrex,
if a token is found, it will return a string with an html tag called span, that has the value of a token
for example:

"an_important_valuee": 
-> "<span class=\"key\">  "an_important_valuee": </span>"

nil is returned if nothing is found
"""

defmodule RegexMatcher do


  def matchKeys(text) do
    match = Regex.run(~r/(?m)^[ ]*[^\r\n:]+?\s*:/,text)
    if match != nil do
      "<span class=\"key\">#{match}</span>"
    else 
      nil
    end
  end


  def matchStrings(text) do
    match = Regex.run(~r/"+[\s,\S]+\w+[\s,\S]+"/,text)
    if match != nil do
      "<span class=\"string\">#{match}</span>"
    else 
      nil
    end
  end


  def matchOperators(text) do 
    match = Regex.run(~r/true|false|,|null/,text)
    if match != nil do
      "<span class=\"op\">#{match}</span>"
    else 
      nil
    end
   end

  def matchNumbers(text) do 
    match = Regex.run(~r/-?\d+\.?\d*([eE]?[-\+]?\d+)?/,text)
    if match != nil do
      "<span class=\"number\">#{match}</span>"
    else 
      nil
    end
  end


  
  def matchBracket(text) do 
    match = Regex.run(~r/\[|\]/,text)
    if match != nil do
      "<span class=\"bracket\">#{match}</span>"
    else 
      nil
    end
  end


  def matchObject(text) do 
    match = Regex.run(~r/\{|\}/,text)
    if match != nil do
      "<span class=\"object\">#{match}</span>"
    else 
      nil
    end
  end

end