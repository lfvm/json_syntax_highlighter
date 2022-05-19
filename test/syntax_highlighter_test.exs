defmodule SyntaxHighlighterTest do
  use ExUnit.Case
  doctest SyntaxHighlighter

  test "Regex allow only keys" do
    assert SyntaxHighlighter.matchKeys( ~s("key":)) == [~s("key":)]
    assert SyntaxHighlighter.matchKeys(~s("123_adf":)) == [~s("123_adf":)]
    # assert SyntaxHighlighter.matchKeys("movie:") == ["po_23243s_2:"]
  end


  test "Regex allow only strings" do
    assert SyntaxHighlighter.matchStrings("abcde") == ["abcde"]
    assert SyntaxHighlighter.matchStrings("123_adf:") == ["123_adf:"]
    assert SyntaxHighlighter.matchStrings("po2 324 3s 2") == ["po2 324 3s 2"]
  end

  test "Regex allow only Booleans" do
    assert SyntaxHighlighter.matchBooleans("false") == ["false"]
    assert SyntaxHighlighter.matchBooleans("adas") == nil
    assert SyntaxHighlighter.matchBooleans("true") == ["true"]
  end

  test "Regex allow only Numberss" do
    assert SyntaxHighlighter.matchNumbers("123") == ["123"]
    assert SyntaxHighlighter.matchNumbers("adas") == nil
    assert SyntaxHighlighter.matchNumbers("5456") == ["5456"]
  end

end
