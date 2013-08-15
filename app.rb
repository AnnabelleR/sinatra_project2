require 'sinatra'
require 'json'

# TODO create a form with a text area.
# Write the code to form a word cloud with the text
# that is pasted into the text area.
get '/' do 
    erb :form
end

# The word_cloud.erb file expects a variable called
# @words_with_frequencies. This should be a JSON array of
# arrays.
#
# As a simple example of something with the right format:
#
# @words_with_frequencies = [['love',5], ['coding',4]].to_json

post '/' do
    text = params[:text]
    words = raw_text(text)
    freqs = frequencies(words)
    @words_with_frequencies = remove_stop_words(freqs).to_a.to_json
    erb :word_cloud
end

def raw_text(text)
        text = raw_text.downcase  # remove capitals
        text = text.gsub(/[^a-z\s]/, '')  # remove everything apart from a-z and spaces
        words= text.split
end

def frequencies(words)
    word_frequencies = Hash.new(0)
    words.each do |word|
        word_frequencies[word] += 1
        end
    return word_frequencies
end

def stop_words
    # Words taken from Jonathan Feinberg's cue.language (via jasondavies.com), see lib/cue.language/license.txt.
    "i|me|my|myself|we|us|our|ours|ourselves|you|your|yours|yourself|yourselves|he|him|his|himself|she|her|hers|herself|it|its|itself|they|them|their|theirs|themselves|what|which|who|whom|whose|this|that|these|those|am|is|are|was|were|be|been|being|have|has|had|having|do|does|did|doing|will|would|should|can|could|ought|im|youre|hes|shes|its|were|theyre|ive|youve|weve|theyve|id|youd|hed|shed|wed|theyd|ill|youll|hell|shell|well|theyll|isnt|arent|wasnt|werent|hasnt|havent|hadnt|doesnt|dont|didnt|wont|wouldnt|shant|shouldnt|cant|cannot|couldnt|mustnt|lets|thats|whos|whats|heres|theres|whens|wheres|whys|hows|a|an|the|and|but|if|or|because|as|until|while|of|at|by|for|with|about|against|between|into|through|during|before|after|above|below|to|from|up|upon|down|in|out|on|off|over|under|again|further|then|once|here|there|when|where|why|how|all|any|both|each|few|more|most|other|some|such|no|nor|not|only|own|same|so|than|too|very|say|says|said|shall"
end

def remove_stop_words(word_frequencies)
    stop_words.split('|').each do |stop_word|
      word_frequencies.delete(stop_word)
    end
end