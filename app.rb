require 'sinatra'

require 'json'

get '/' do
    erb :form
end

post '/' do
    text = params[:text]
    words = text_to_words(text)
    freqs = count_words(words)
    @words_with_frequencies = filter_out_stopwords(freqs).to_a.to_json
    erb :word_cloud
end

# The functions to make it all work:
# ----------------------------------

def text_to_words(text)
    text = text.downcase
    text = text.gsub(/[^a-z\s]/, '')  # remove everything apart from a-z and spaces
    words = text.split
end

def count_words(words)
    h = Hash.new(0)
    words.each {|w| h[w] += 1}
    h
end

# stop_words are common filling words that should be removed
# before doing word visualisations
def stop_words
    # Words taken from Jonathan Feinberg's cue.language (via jasondavies.com), see lib/cue.language/license.txt.
    "i|me|my|myself|we|us|our|ours|ourselves|you|your|yours|yourself|yourselves|he|him|his|himself|she|her|hers|herself|it|its|itself|they|them|their|theirs|themselves|what|which|who|whom|whose|this|that|these|those|am|is|are|was|were|be|been|being|have|has|had|having|do|does|did|doing|will|would|should|can|could|ought|im|youre|hes|shes|its|were|theyre|ive|youve|weve|theyve|id|youd|hed|shed|wed|theyd|ill|youll|hell|shell|well|theyll|isnt|arent|wasnt|werent|hasnt|havent|hadnt|doesnt|dont|didnt|wont|wouldnt|shant|shouldnt|cant|cannot|couldnt|mustnt|lets|thats|whos|whats|heres|theres|whens|wheres|whys|hows|a|an|the|and|but|if|or|because|as|until|while|of|at|by|for|with|about|against|between|into|through|during|before|after|above|below|to|from|up|upon|down|in|out|on|off|over|under|again|further|then|once|here|there|when|where|why|how|all|any|both|each|few|more|most|other|some|such|no|nor|not|only|own|same|so|than|too|very|say|says|said|shall"
end

def filter_out_stopwords(h)
    h.reject {|k, v| stop_words.include?(k)}
end