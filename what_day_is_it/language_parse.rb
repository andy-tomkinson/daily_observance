require 'open-nlp'
require 'nokogiri'

OpenNLP.load

sent = "The death of the poet was kept from his poems."
tokenizer = OpenNLP::SimpleTokenizer.new

tokens = tokenizer.tokenize(sent).to_a
# => %w[The death of the poet was kept from his poems .]

p tokens